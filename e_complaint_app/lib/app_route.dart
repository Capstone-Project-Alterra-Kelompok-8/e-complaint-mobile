import 'package:e_complaint_app/views/screens/auth/create_new_password_screen.dart';
import 'package:e_complaint_app/views/screens/auth/forget_password_screen.dart';
import 'package:e_complaint_app/views/screens/auth/login_screen.dart';
import 'package:e_complaint_app/views/screens/auth/register/register.dart';
import 'package:e_complaint_app/views/screens/auth/register/verifikasi_link.dart';
import 'package:e_complaint_app/views/screens/auth/register/verifikasi_otp.dart';
import 'package:e_complaint_app/views/screens/home/changeprofile_input_screen.dart';
import 'package:e_complaint_app/views/screens/home/changeprofile_screen.dart';
import 'package:e_complaint_app/views/screens/home/homepage_screen.dart';
import 'package:e_complaint_app/views/screens/home/profile_screen.dart';
import 'package:e_complaint_app/views/screens/news/news_screen.dart';
import 'package:e_complaint_app/views/screens/news/components/news_detail.dart';
import 'package:flutter/material.dart';



class AppRoute {
  static final Map<String, WidgetBuilder> routes = {
    '/login' : (context) => const LoginScreen(),
    '/register' : (context) => const RegisterScreen(),
    '/verifikasi_link' : (context) => const VerifikasiLink(),
    '/verifikasi_otp' : (context) => const VerifikasiOtp(),
    '/new_password' : (context) => const NewPasswordScreen(),
    '/news' :(context) => const NewsScreen(),
    '/forgot_password' : (context) => ForgotPasswordScreen(),
    '/home' : (context) => const HomePageScreen(),
    '/change_profile_input' : (context) => const ChangeProfileInputScreen(),
    '/change_profile' : (context) => const ChangeProfileScreen(),
    '/profile' : (context) => const ProfileScreen(),
  };
  
}