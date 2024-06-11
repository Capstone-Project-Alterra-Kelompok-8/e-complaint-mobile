import 'package:e_complaint_app/views/screens/mycomplaint/my_complaint_screen.dart';
import 'package:e_complaint_app/views/screens/mycomplaint/detail_my_complaint.dart';
import 'package:e_complaint_app/views/screens/mycomplaint/progress_my_complaint.dart';
import 'package:e_complaint_app/views/screens/auth/create_new_password_screen.dart';
import 'package:e_complaint_app/views/screens/auth/forget_password_screen.dart';
import 'package:e_complaint_app/views/screens/auth/login_screen.dart';
import 'package:e_complaint_app/views/screens/auth/register/register.dart';
import 'package:e_complaint_app/views/screens/auth/register/verifikasi_link.dart';
import 'package:e_complaint_app/views/screens/auth/register/verifikasi_otp.dart';
import 'package:e_complaint_app/views/screens/home/homepage_screen.dart';
import 'package:e_complaint_app/views/screens/news/news_screen.dart';
import 'package:e_complaint_app/views/screens/news/components/news_detail.dart';
import 'package:e_complaint_app/views/screens/notification/notification_screen.dart';
import 'package:flutter/material.dart';




class AppRoute {
  static final Map<String, WidgetBuilder> routes = {
    '/login' : (context) => LoginScreen(),
    '/register' : (context) => RegisterScreen(),
    '/verifikasi_link' : (context) => VerifikasiLink(),
    '/verifikasi_otp' : (context) => VerifikasiOtp(),
    '/new_password' : (context) => NewPasswordScreen(),
    '/news' :(context) => NewsScreen(),

    '/login' : (context) => const LoginScreen(),
    '/register' : (context) => const RegisterScreen(),
    '/verifikasi_link' : (context) => const VerifikasiLink(),
    '/verifikasi_otp' : (context) => const VerifikasiOtp(),
    '/new_password' : (context) => const NewPasswordScreen(),
    '/news' :(context) => const NewsScreen(),
    '/forgot_password' : (context) => ForgotPasswordScreen(),
    '/notification' : (context) => NotificationScreen(),
    '/my_complaint' : (context) => MyComplaintScreen(),
    '/detail_my_complaint' : (context) => DetailMyComplaintScreen(),
    '/progress_my_complaint' : (context) => ProgressMyComplaintScreen(),
   
  };
  
}