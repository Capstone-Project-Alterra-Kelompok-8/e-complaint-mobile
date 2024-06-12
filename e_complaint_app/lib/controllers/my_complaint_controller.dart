import 'package:e_complaint_app/models/my_complaint_model.dart';
import 'package:e_complaint_app/services/my_complaint_service.dart';
import 'package:flutter/material.dart';

class MyComplaintController extends ChangeNotifier {
  final MyComplaintService _myComplaintService = MyComplaintService();
  List<MyComplaintModel> _myComplaints = [];
  bool _isLoaded = false;
  String _errorMessage = '';
  String? _filterStatus;

  List<MyComplaintModel> get myComplaint => _myComplaints;
  bool get isLoaded => _isLoaded;
  String get errorMessage => _errorMessage;

  Future<void> getMyComplaint() async {
    try {
      final response = await _myComplaintService.getMyComplaint();

      print('getNews response: $response');

      if (response != null && response.statusCode == 200) {
        _myComplaints.clear();
        final Map<String, dynamic> responseData = response.data;
        if (responseData.containsKey('data')) {
          final List<dynamic> newsData = responseData['data'];
          newsData.forEach((item) {
            final news = MyComplaintModel.fromJson(item);
            _myComplaints.add(news);
          });

          print('getMyComplaint berhasil dimuat');
          print(': $_myComplaints');
        } else {
          _errorMessage = 'Data field is missing in the response';
        }
      } else {
        _errorMessage = 'Failed to load My Complaint: ${response?.statusCode}';
        print('Response kosong atau tidak berhasil: ${response?.statusCode}');
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      print('Error: $e');
    } finally {
      _isLoaded = true; // Only update status if request is completed
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
      return myComplaint;
    }
    return myComplaint.where((complaint) => complaint.status == _filterStatus).toList();
  }

  final Map<String, Color> _statusColorMap = {
    'pending': Colors.grey,
    'selesai': Colors.green,
    'ditolak': Colors.red,
    'on progres': Colors.orange,
    'verifikasi': Colors.blue,
  };
}
