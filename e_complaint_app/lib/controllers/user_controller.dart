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


  String get name => _user?.name ?? '';
  String get email => _user?.email ?? '';
  String get telephoneNumber => _user?.telephoneNumber ?? '';
  String get profilePhoto =>
      _user?.profilePhoto ??
      'https://storage.googleapis.com/e-complaint-assets/complaint_files/example1.jpg';
}
