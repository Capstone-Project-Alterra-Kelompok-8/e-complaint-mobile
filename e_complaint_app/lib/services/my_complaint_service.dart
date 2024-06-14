import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyComplaintService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/';

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Response?> getMyComplaint() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await _dio.get(
        '${_baseUrl}users/complaints',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
      
    } catch (e) {
      print('Error in getMyComplaint: $e');
      return null;
    }
  }

  Future<Response?> getMyComplaintProses(String complaintId) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await _dio.get(
        '${_baseUrl}complaints/$complaintId/processes',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      print('Error in getMyComplaintProses: $e');
      return null;
    }
  }
}