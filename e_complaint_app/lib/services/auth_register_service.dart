import 'package:dio/dio.dart';
import '../models/auth_model.dart';

class RegisterUserService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id';
Future<void> register(UserRegisterModel user) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/api/v1/users/register',
        data: user.toJson(),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to register user: ${response.statusCode} ${response.statusMessage}');
      }
    } on DioError catch (e) {
      throw Exception('Failed to register user: ${e.response?.data ?? e.message}');
    }
  }


}
