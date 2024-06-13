import 'package:e_complaint_app/models/user_model.dart';
import 'package:e_complaint_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController with ChangeNotifier {
  String _name = '';
  String _email = '';
  String _telephoneNumber = '';
  String _profilePhotoUrl = '';

  String get name => _name;
  String get email => _email;
  String get telephoneNumber => _telephoneNumber;
  String get profilePhotoUrl => _profilePhotoUrl;

  final UserService _userService = UserService();

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    if (userId != null) {
      User? user = await _userService.getUserById(userId);
      if (user != null) {
        _name = user.name;
        _email = user.email;
        _telephoneNumber = user.telephoneNumber;
        _profilePhotoUrl = user.profilePhotoPath;
        notifyListeners();
      }
    } else {
      _name = prefs.getString('name') ?? '';
      _email = prefs.getString('email') ?? '';
      _telephoneNumber = prefs.getString('telephoneNumber') ?? '';
      _profilePhotoUrl = prefs.getString('profilePhotoUrl') ?? '';
      notifyListeners();
    }
  }

  Future<void> updateUserData(String name, String email, String telephoneNumber,
      String profilePhotoPath) async {
    final profilePhotoUrl =
        'https://storage.googleapis.com/e-complaint-assets/$profilePhotoPath';

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('telephoneNumber', telephoneNumber);
    await prefs.setString('profilePhotoUrl', profilePhotoUrl);
    _name = name;
    _email = email;
    _telephoneNumber = telephoneNumber;
    _profilePhotoUrl = profilePhotoUrl;
    notifyListeners();
  }
}
