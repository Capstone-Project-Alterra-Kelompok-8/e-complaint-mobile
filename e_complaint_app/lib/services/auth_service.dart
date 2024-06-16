import 'dart:convert';

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

  Future<void> sendOtpForgotPassword(String email) async {
    const String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1';
    try {
      final response = await _dio.post(
        '$_baseUrl/users/forgot-password/send-otp',
        data: jsonEncode({
          'email': email,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send otp');
      }
    } catch (e) {
      print('Error sending otp: $e');
    }
  }

    Future<void> verifyOtpForgotPassword(String email, String otp) async {
    final String url = '$_baseUrl/users/forgot-password/verify-otp';
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

  Future<void> changePasswordForgotPassword(String email, newPassword) async {
    const String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1';
    try {
      final response = await _dio.put(
        '$_baseUrl/users/forgot-password/change-password',
        data: jsonEncode({
          'email': email,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      print('Error changing password: $e');
    }
  }

}
