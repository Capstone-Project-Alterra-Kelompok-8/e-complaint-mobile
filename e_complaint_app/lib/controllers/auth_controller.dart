import 'package:flutter/widgets.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';

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
        Navigator.pushNamed(context, verificationLinkRouteName, arguments: email);
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


// class LoginAuthController with ChangeNotifier {
//   final AuthLoginService _authLoginService = AuthLoginService();
//   String? _token;

//   String? get token => _token;

//   Future<void> login(BuildContext context, String email, String password) async {
//     if (email.isNotEmpty && password.isNotEmpty) {
//       try {
//         final loginResponse = await _authLoginService.login(email, password);
//         _token = loginResponse.data.token;
//         // Simpan token
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', _token!);

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Login successful')),
//         );
//         Navigator.pushReplacementNamed(context, '/news');


//         notifyListeners();
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Login failed: $e')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill in all fields')),
//       );
//     }
//   }
// }

