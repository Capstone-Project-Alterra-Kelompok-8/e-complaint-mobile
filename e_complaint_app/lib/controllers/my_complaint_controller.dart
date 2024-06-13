import 'package:e_complaint_app/models/my_complaint_model.dart';
import 'package:e_complaint_app/services/my_complaint_service.dart';
import 'package:flutter/material.dart';

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
    'pending': Colors.grey,
    'selesai': Colors.green,
    'ditolak': Colors.red,
    'on progress': Colors.orange,
    'verifikasi': Colors.blue,
  };

  Future<void> getMyComplaint() async {
    try {
      final response = await _myComplaintService.getMyComplaint();

      if (response != null && response.statusCode == 200) {
        _myComplaints.clear();
        final Map<String, dynamic> responseData = response.data;

        if (responseData.containsKey('data')) {
          final List<dynamic> myComplaintData = responseData['data'];

          myComplaintData.forEach((item) {
            final myComplaint = MyComplaintModel.fromJson(item);
            _myComplaints.add(myComplaint);
          });

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
