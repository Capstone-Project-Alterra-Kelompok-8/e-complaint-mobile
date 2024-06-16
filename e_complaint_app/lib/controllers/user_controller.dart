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

  Future<void> changePassword(String newPassword, confirmNewPassword) async {
    try {
      if (newPassword.isEmpty) {
        throw Exception('New password cannot be empty');
      }
      await _userService.changePassword(newPassword, confirmNewPassword);
      notifyListeners();
    } catch (e) {
      debugPrint('error $e');
      throw e;
    }
  }

  Future<void> changeProfile(String name, telephone_number, email) async {
    try{
      if (name.isEmpty && email.isEmpty && telephoneNumber.isEmpty){
        throw Exception('Name, telephone number and email cannot be empty');
      }
      await _userService.changeProfile(name, telephone_number, email);
      notifyListeners();
    } catch (e) {
      debugPrint('error $e');
      throw e;
    }
  }



  String get name => _user?.name ?? '';
  String get email => _user?.email ?? '';
  String get telephoneNumber => _user?.telephoneNumber ?? '';
  String get profilePhoto =>
      _user?.profilePhoto ??
      'https://storage.googleapis.com/e-complaint-assets/complaint_files/example1.jpg';
}
