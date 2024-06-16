import 'package:dio/dio.dart';
import 'package:e_complaint_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://capstone-dev.mdrizki.my.id/api/v1',
  ));

  Future<User> getUserById(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('id');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await _dio.get(
        '/users/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['status'] == true && responseData['data'] != null) {
          return User.fromJson(responseData['data']);
        } else {
          throw Exception('Failed to load user: ${responseData['message']}');
        }
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load user: ${e.message}');
    }
  }
}
