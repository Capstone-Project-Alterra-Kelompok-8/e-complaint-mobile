import 'package:e_complaint_app/views/screens/auth/create_new_password_screen.dart';
import 'package:e_complaint_app/views/screens/auth/login_screen.dart';
import 'package:e_complaint_app/views/screens/auth/register/register.dart';
import 'package:e_complaint_app/views/screens/auth/register/verifikasi_link.dart';
import 'package:e_complaint_app/views/screens/news/news_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static final Map<String, WidgetBuilder> routes = {
    '/login' : (context) => LoginScreen(),
    '/register' : (context) => RegisterScreen(),
    '/verifikasi_link' : (context) => VerifikasiLink(),
    '/new_password' : (context) => NewPasswordScreen(),
    '/news' :(context) => NewsScreen(),
  };
  
}