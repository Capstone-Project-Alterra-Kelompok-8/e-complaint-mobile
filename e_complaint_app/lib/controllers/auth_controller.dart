import 'package:e_complaint_app/services/login_service.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class RegisterAuthController with ChangeNotifier {
  final RegisterUserService _registerUserService = RegisterUserService();

  Future<void> register(
    BuildContext context,
    String name,
    String email,
    String telephoneNumber,
    String password,
    String verificationLinkRouteName,
  ) async {
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        telephoneNumber.isNotEmpty &&
        password.isNotEmpty) {
      final user = UserRegisterModel(
        name: name,
        email: email,
        telephoneNumber: telephoneNumber,
        password: password,
      );

      try {
        await _registerUserService.register(user);
        debugPrint('Registration successful');
        await sendOtp(context, email, verificationLinkRouteName);
      } catch (e) {
        debugPrint('Registration failed: $e');
      }
    } else {
      debugPrint('All fields must be filled');
    }
  }

  Future<void> sendOtp(BuildContext context, String email,
      String verificationLinkRouteName) async {
    if (email.isNotEmpty) {
      try {
        await _registerUserService.sendOtp(email);
        debugPrint('OTP sent successfully');
        Navigator.pushNamed(context, verificationLinkRouteName,
            arguments: email);
      } catch (e) {
        debugPrint('Failed to send OTP: $e');
      }
    } else {
      debugPrint('Email field must be filled');
    }
  }

  Future<void> verifyOtp(BuildContext context, String email, String otp) async {
    if (email.isNotEmpty && otp.isNotEmpty) {
      try {
        await _registerUserService.verifyOtp(email, otp);
        debugPrint('OTP verified successfully');
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        debugPrint('OTP verification failed: $e');
      }
    } else {
      debugPrint('Email and OTP fields must be filled');
    }
  }
}

class LoginAuthController with ChangeNotifier {
  final AuthLoginService _loginService = AuthLoginService();

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final response = await _loginService.login(email, password);
      if (response.status) {
        debugPrint('Success Login');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data.token);
        await prefs.setString('email', response.data.email);
        Navigator.pushReplacementNamed(context, '/news');
      } else {
        debugPrint(response.message);
      }
    } catch (e) {
      debugPrint('Failed to Login \n$e');
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
