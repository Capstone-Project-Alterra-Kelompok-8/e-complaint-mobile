import 'package:dio/dio.dart';

class MyComplaintService{
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/';
  final String _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IlVzZXIgMSIsImVtYWlsIjoidXNlcjFAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.ZuyGmrYaQkML-NIxNlUYn7r4U36tAYkquZfFUzcNZFc';

   Future getMyComplaint () async {
    var baseUrl = '${_baseUrl}complaints';   
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
