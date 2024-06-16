import 'package:e_complaint_app/constants/constants.dart';
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

  Future<void> sendOtpForgotPassword(BuildContext context, String email) async {
    _isLoading = true;
    notifyListeners();
    if (email.isNotEmpty) {
      try {
        final prefs = await SharedPreferences.getInstance();
        await _registerUserService.sendOtpForgotPassword(email);
        await prefs.setString('email', email);
        Navigator.pushNamed(context, '/verifikasi_otp_forgot_password');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP sent successfully'),
          ),
        );
        debugPrint('OTP sent successfully');
      } catch (e) {
        debugPrint('Failed to send OTP: $e');
        _isLoading = false;
        notifyListeners();
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<String?> _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<void> verifyOtpForgotPassword(BuildContext context, String otp) async {
    _isLoading = true;
    notifyListeners();
    final email = await _getEmail();
    if (email != null && otp.isNotEmpty) {
      try {
        await _registerUserService.verifyOtpForgotPassword(email, otp);
        debugPrint('OTP verified successfully');
        Navigator.pushReplacementNamed(context, '/new_password');
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
      debugPrint('Failed to verify');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to verify'),
        ),
      );
    }
  }

  Future<void> changePasswordForgotPassword(
      BuildContext context, String newPassword) async {
    _isLoading = true;
    notifyListeners();
    final email = await _getEmail();
    if (email != null) {
      try {
        if (newPassword.isEmpty) {
          throw Exception('New password cannot be empty');
        }
        await _registerUserService.changePasswordForgotPassword(
            email, newPassword);
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully'),
          ),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/successmark.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Kata Sandi diubah!',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                    ),
                    const Text('Kata sandi anda telah'),
                    const Text('berhasil diubah'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorCollections.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Kembali ke masuk',
                        style: TextStyle(
                          color: ColorCollections.textSecondaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } catch (e) {
        _isLoading = false;
        notifyListeners();
        debugPrint('Error changing password: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error changing password: $e'),
          ),
        );
        throw e;
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _isLoading = false;
      notifyListeners();
      debugPrint('No email found in shared preferences');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No email found, please try again'),
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
