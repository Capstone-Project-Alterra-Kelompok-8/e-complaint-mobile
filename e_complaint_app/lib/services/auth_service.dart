import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/auth_model.dart';

class RegisterUserService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1';

  Future<void> register(UserRegisterModel user) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/users/register',
        data: user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Success Register');
        debugPrint('Response: ${response.data}');
      } else {
        debugPrint(
            'Failed to register: ${response.statusCode} ${response.statusMessage}');
        throw Exception('Failed to register: ${response.statusMessage}');
      }
      
    } catch (e) {
      debugPrint('Failed to register user: $e');
      throw Exception('Failed to register user: $e');
    }
  }

  Future<void> sendOtp(String email) async {
    final String url = '$_baseUrl/users/register/send-otp';
    debugPrint('Sending OTP to: $email using URL: $url');

    try {
      final response = await _dio.post(
        url,
        data: {'email': email},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('OTP sent successfully');
        debugPrint('Response: ${response.data}');
      } else {
        debugPrint(
            'Failed to send OTP: ${response.statusCode} ${response.statusMessage}');
        throw Exception('Failed to send OTP: ${response.statusMessage}');
      }
    } catch (e) {
      debugPrint('Failed to send OTP: $e');
      throw Exception('Failed to send OTP: $e');
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    final String url = '$_baseUrl/users/register/verify-otp';
    debugPrint('Verifying OTP to: $email using URL: $url');

    try {
      final response = await _dio.post(
        url,
        data: {'email': email, 'otp': otp},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('OTP verified successfully');
        debugPrint('Response: ${response.data}');
      } else {
        debugPrint(
            'Failed to verify OTP: ${response.statusCode} ${response.statusMessage}');
        throw Exception('Failed to verify OTP: ${response.statusMessage}');
      }
    } catch (e) {
      debugPrint('Failed to verify OTP: $e');
      throw Exception('Failed to verify OTP: $e');
    }
  }

}
