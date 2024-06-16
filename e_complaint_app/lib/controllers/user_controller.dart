import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/models/user_model.dart';
import 'package:e_complaint_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController with ChangeNotifier {
  final UserService _userService = UserService();
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUserData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('id');

      if (userId != null) {
        _user = await _userService.getUserById(userId);
        debugPrint("User data loaded: ${_user?.name}");
      } else {
        throw Exception('User ID not found in shared preferences');
      }
    } catch (e) {
      _error = e.toString();
      debugPrint("Error loading user data: $_error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changePassword(
      BuildContext context, String newPassword, confirmNewPassword) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      if (newPassword.isEmpty) {
        throw Exception('New password cannot be empty');
      }
      await _userService.changePassword(newPassword, confirmNewPassword);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              height: 440,
              width: 348,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 54,
                  ),
                  Image.asset(
                    'assets/images/succes_mark_icon.png',
                    width: 123,
                    height: 99,
                  ),
                  const SizedBox(height: 60),
                  Text('Password Berhasil Diubah',
                      style: HomeTextCollections.dialogTitleChangePassword),
                  Text(
                    'Selamat password terbaru kamu\ntelah berhasil di ubah',
                    textAlign: TextAlign.center,
                    style: HomeTextCollections.titleButtonChangePassword,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorCollections.alertSuccessColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Kembali Halaman Profile',
                        style: HomeTextCollections.dialogTitleChangePassword),
                  ),
                ],
              ),
            ),
          );
        },
      );
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('error $e');
      throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changeProfile(String name, telephone_number, email) async {
    _isLoading = true;
    notifyListeners();
    try {
      if (name.isEmpty && email.isEmpty && telephoneNumber.isEmpty) {
        throw Exception('Name, telephone number and email cannot be empty');
      }
      await _userService.changeProfile(name, telephone_number, email);

      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('error $e');
      throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String get name => _user?.name ?? '';
  String get email => _user?.email ?? '';
  String get telephoneNumber => _user?.telephoneNumber ?? '';
  String get profilePhoto =>
      _user?.profilePhoto ??
      'https://storage.googleapis.com/e-complaint-assets/complaint_files/example1.jpg';
}
