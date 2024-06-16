import 'package:e_complaint_app/controllers/profile_controller.dart';
import 'package:e_complaint_app/services/login_service.dart';
import 'package:provider/provider.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class RegisterAuthController with ChangeNotifier {
  final RegisterUserService _registerUserService = RegisterUserService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

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
      _isLoading = true;
      notifyListeners();
      try {
        await _registerUserService.register(user);
        debugPrint('Registration successful');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', name);
        await prefs.setString('email', email);
        await prefs.setString('telephoneNumber', telephoneNumber);

        final profileController =
            Provider.of<ProfileController>(context, listen: false);
        await profileController.updateUserData(name, email, telephoneNumber);
        await sendOtp(context, email, verificationLinkRouteName);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registrasi Berhasil'),
          ),
        );
      } catch (e) {
        _isLoading = false;
        notifyListeners();
        debugPrint('Registration failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Koneksi Eror'),
          ),
        );
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _isLoading = false;
      notifyListeners();
      debugPrint('All fields must be filled');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All fields must be filled'),
        ),
      );
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
    _isLoading = true;
    notifyListeners();
    if (email.isNotEmpty && otp.isNotEmpty) {
      try {
        await _registerUserService.verifyOtp(email, otp);
        debugPrint('OTP verified successfully');
        Navigator.pushReplacementNamed(context, '/login');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP verified successfully'),
          ),
        );
      } catch (e) {
        _isLoading = false;
        notifyListeners();
        debugPrint('OTP verification failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP verification failed'),
            
          ),
        );
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _isLoading = false;
      notifyListeners();
      debugPrint('Failed to verify');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to verify'),
        ),
      );
    }
  }
}

class LoginAuthController with ChangeNotifier {
  final AuthLoginService _loginService = AuthLoginService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // bool _isLoginButtonEnabled = false;

  // LoginController() {
  //   emailController.addListener(_updateButtonState);
  //   passwordController.addListener(_updateButtonState);
  // }

  // bool get isLoginButtonEnabled => _isLoginButtonEnabled;

  // void _updateButtonState() {
  //   final isEnabled =
  //       emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  //   if (_isLoginButtonEnabled != isEnabled) {
  //     _isLoginButtonEnabled = isEnabled;
  //     notifyListeners();
  //   }
  // }

  // @override
  // void dispose() {
  //   emailController.removeListener(_updateButtonState);
  //   passwordController.removeListener(_updateButtonState);
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  Future<void> login(
      BuildContext context, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _loginService.login(email, password);
      if (response.status && response.data != null) {
        debugPrint('Success Login');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('name', response.data!.name);
        await prefs.setString('token', response.data!.token);
        await prefs.setInt('id', response.data!.id);
        // await prefs.setString('email', response.data!.email);
        Navigator.pushReplacementNamed(context, '/home');
      } else if (!response.status &&
          response.message == 'invalid username or password') {
        _isLoading = false;
        notifyListeners();
        debugPrint('Invalid credentials');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username atau password salah')),
        );
      } else {
        _isLoading = false;
        notifyListeners();
        debugPrint('Failed to Login: ${response.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${response.message}')),
        );
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Failed to Login \n$e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Koneksi Error')),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    _isLoading = false;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('id');
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
