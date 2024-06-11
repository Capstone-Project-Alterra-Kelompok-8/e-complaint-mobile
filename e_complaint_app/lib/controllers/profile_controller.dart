import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController with ChangeNotifier {
  String _name = '';
  String _email = '';
  String _telephoneNumber = '';

  String get name => _name;
  String get email => _email;
  String get telephoneNumber => _telephoneNumber;

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? '';
    _email = prefs.getString('email') ?? '';
    _telephoneNumber = prefs.getString('telephoneNumber') ?? '';
    notifyListeners();
  }

  Future<void> updateUserData(String name, String email, String telephoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('telephoneNumber', telephoneNumber);
    _name = name;
    _email = email;
    _telephoneNumber = telephoneNumber;
    notifyListeners();
  }
}
