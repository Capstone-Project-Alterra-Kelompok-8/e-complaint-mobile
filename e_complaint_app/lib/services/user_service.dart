import 'dart:convert';

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

  Future<void> changePassword(String newPassword, confirmNewPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    const String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1';
    try {
      final response = await _dio.put(
        '$_baseUrl/users/change-password',
        data: jsonEncode({
          'new_password': newPassword,
          'confirm_new_password': newPassword,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      print('Error changing password: $e');
    }
  }

  Future<void> changeProfile(String name, telephoneNumber, email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    const String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1';
    try {
      final response = await _dio.put(
        '$_baseUrl/users/update-profile',
        data: jsonEncode({
          'name': name,
          'telephone_number': telephoneNumber,
          'email': email,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to change profile');
      }
    } catch (e) {
      print('Error changing profile: $e');
    }
  }
}
