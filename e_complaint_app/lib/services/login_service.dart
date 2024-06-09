import 'package:dio/dio.dart';
import '../models/login_model.dart';

class AuthLoginService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1';

  Future<LoginResponse> login(String email, String password) async {
    final response = await _dio.post(
      '$_baseUrl/users/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to login');
    }
  }
}
