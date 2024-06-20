import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/';

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future getNotification() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await _dio.get(
        '${_baseUrl}users/activities',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      print('Error in getNotification: $e');
      return null;
    }
  }
}