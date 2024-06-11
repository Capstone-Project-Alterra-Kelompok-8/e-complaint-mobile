import 'package:dio/dio.dart';
import 'package:e_complaint_app/models/login_model.dart';

class AuthLoginService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1';

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/users/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(response.data);
      } else {
        return LoginResponse(
          status: false,
          message: 'Failed to login',
          statusCode: response.statusCode ?? 0,
        );
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
