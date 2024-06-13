import 'package:dio/dio.dart';
import 'package:e_complaint_app/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyComplaintService{

  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/';
  final String _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IlVzZXIgMSIsImVtYWlsIjoidXNlcjFAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.ZuyGmrYaQkML-NIxNlUYn7r4U36tAYkquZfFUzcNZFc';

   Future getMyComplaint () async {
    var baseUrl = '${_baseUrl}users/complaints';   
    final response = await _dio.get(
      baseUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
          
        },

      ),
      
    );
    return response;

  }

 Future<Response> getMyComplaintProses(String complaintId) async {
  var baseUrl = '${_baseUrl}complaints/$complaintId/processes';
  
  print('Request URL: $baseUrl');
  print('Request Headers: ${{
    'Authorization': 'Bearer $_token',
  }}');
  
  final response = await _dio.get(
    baseUrl,
    options: Options(
      headers: {
        'Authorization': 'Bearer $_token',
      },
    ),
  );
  return response;
}


}

