import 'package:e_complaint_app/models/auth_model.dart';
import 'package:e_complaint_app/services/auth_register_service.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class RegisterAuthController with ChangeNotifier {
  final RegisterUserService _registerUserService = RegisterUserService();

  Future<void> register(
    BuildContext context,
    String name,
    String email,
    String telephoneNumber,
    String password,
  ) async {
    if (name.isNotEmpty && email.isNotEmpty && telephoneNumber.isNotEmpty && password.isNotEmpty) {
      final user = UserRegisterModel(
        name: name,
        email: email,
        telephoneNumber: telephoneNumber,
        password: password,
      );
      try {
        await _registerUserService.register(user);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('all fields must be filled')),
      );
    }
  }
}
