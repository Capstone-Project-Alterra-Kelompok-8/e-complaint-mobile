import 'dart:convert';

import 'package:e_complaint_app/models/my_complaint_model.dart';
import 'package:e_complaint_app/services/my_complaint_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyComplaintController extends ChangeNotifier {
  final MyComplaintService _myComplaintService = MyComplaintService();
  List<MyComplaintModel> _myComplaints = [];
  List<MyComplaintProsesModel> _myComplaintProses = [];
  bool _isLoaded = false;
  String _errorMessage = '';
  String? _filterStatus;

  List<MyComplaintModel> get myComplaints => _myComplaints;
  List<MyComplaintProsesModel> get myComplaintProses => _myComplaintProses;
  bool get isLoaded => _isLoaded;
  String get errorMessage => _errorMessage;

  final Map<String, Color> _statusColorMap = {
    'Pending': Colors.grey,
    'Selesai': Colors.green,
    'Ditolak': Colors.red,
    'On Progress': Colors.orange,
    'Verifikasi': Colors.blue,
  };

  Future<void> getMyComplaint() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? complaintsJson = prefs.getString('myComplaints');

      final response = await _myComplaintService.getMyComplaint();
      print('Response: $response');

      if (response != null && response.statusCode == 200) {
        _myComplaints.clear();
        final Map<String, dynamic> responseData = response.data;

        if (responseData.containsKey('data')) {
          final List<dynamic> myComplaintData = responseData['data'];

          myComplaintData.forEach((item) {
            final myComplaint = MyComplaintModel.fromJson(item);
            _myComplaints.add(myComplaint);
            
          });
          prefs.setString('myComplaints', json.encode(_myComplaints));
          _errorMessage = '';
          print('My complaints loaded successfully');
        } else {
          _errorMessage = 'Data field is missing in the response';
        }
      } else {
        _errorMessage = 'Failed to load My Complaints: ${response?.statusCode}';
        print('Response is empty or request failed: ${response?.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      print('Error: $e');
    } finally {
      _isLoaded = true; // Only update status if request is completed
      notifyListeners();
    }
  }

  Future<void> getComplaintProcesses(String complaintId) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? complaintsProsesJson = prefs.getString('myComplaintsProses');
    final response = await _myComplaintService.getMyComplaintProses(complaintId);

    if (response != null && response.statusCode == 200) {
      final responseData = response.data;

      if (responseData != null && responseData['status'] == true) {
        final List<dynamic>? processData = responseData['data'];

        _myComplaintProses.clear();

        if (processData != null) {
          for (var item in processData) {
            final process = MyComplaintProsesModel.fromJson(item);
            _myComplaintProses.add(process);
            
          }
          prefs.setString('myComplaintsProses', json.encode(_myComplaintProses));
          _errorMessage = '';
        } else {
          _errorMessage = 'No complaint processes found for this complaint ID.';
        }
      } else {
        _errorMessage = 'Response status is not true or missing';
      }
    } else {
      _errorMessage = 'Failed to load Complaint Processes: ${response?.statusCode}';
    }
  } catch (e) {
    _errorMessage = 'Error: $e';
    print('Error: $e');
  } finally {
    _isLoaded = true;
    notifyListeners();
  }
}


  void setFilterStatus(String? status) {
    _filterStatus = status;
    notifyListeners();
  }

  void clearFilter() {
    _filterStatus = null;
    notifyListeners();
  }

  List<MyComplaintModel> get filteredComplaints {
    if (_filterStatus == null) {
      return myComplaints;
    }
    return myComplaints.where((complaint) => complaint.status == _filterStatus).toList();
  }
}


class MyComplaintCommentController extends ChangeNotifier {
  final MyComplaintCommentService _myComplaintCommentService = MyComplaintCommentService();
  List<CommentModel> _myComplaintsComment = [];
  bool _isLoaded = false;
  String _errorMessage = '';

  List<CommentModel> get myComplaintsComment => _myComplaintsComment;
  bool get isLoaded => _isLoaded;
  String get errorMessage => _errorMessage;
  
  Future<void> getMyComplaintComment(String complaintId) async {
     try {

      final response = await _myComplaintCommentService.getMyComplaintComment(complaintId);
      print('Response: $response');

      if (response != null && response.statusCode == 200) {
        _myComplaintsComment.clear();
        final Map<String, dynamic> responseData = response.data;
        if (responseData.containsKey('data')) {
          final List<dynamic> myComplaintCommentData = responseData['data'];

          myComplaintCommentData.forEach((item) {
            final myComplaintComment = CommentModel.fromJson(item);
            _myComplaintsComment.add(myComplaintComment);
            
          });
          _errorMessage = '';
          print('My complaints comment loaded successfully');
        } else {
          _errorMessage = 'Data field is missing in the response';
        }
      } else {
        _errorMessage = 'Failed to load My Complaints Comment: ${response?.statusCode}';
        print('Response is empty or request failed: ${response?.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      print('Error: $e');
    } finally {
      _isLoaded = true; // Only update status if request is completed
      notifyListeners();
    }

  }

  Future<void> postMyComplaintComment(String complaintId, String comment) async {
    try {
      final response = await _myComplaintCommentService.postMyComplaintComment(complaintId, comment);
      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        await getMyComplaintComment(complaintId); // Refresh comments after posting a new one
        _errorMessage = ''; // Clear error message if successful
        print('Comment posted successfully');
      } else {
        _errorMessage = 'Failed to post comment: ${response?.statusCode}';
        print('Failed to post comment: ${response?.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      print('Error: $e');
    } finally {
      notifyListeners();
    }
  }
    
}