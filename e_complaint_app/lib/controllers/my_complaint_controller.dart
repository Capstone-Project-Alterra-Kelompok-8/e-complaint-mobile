import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/models/my_complaint_model.dart';
import 'package:e_complaint_app/services/my_complaint_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyComplaintController extends ChangeNotifier{
  final MyComplaintService _myComplaintService = MyComplaintService();
  List<MyComplaintModel> _myComplaints = [];
  bool _isLoaded = false;
  String _errorMessage = '';


  List <MyComplaintModel> get myComplaint => _myComplaints;
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





}