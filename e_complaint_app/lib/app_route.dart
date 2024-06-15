import 'package:e_complaint_app/views/screens/auth/splashscreen.dart';
import 'package:e_complaint_app/views/screens/customer_services/chat_admin.dart';
import 'package:e_complaint_app/views/screens/customer_services/chat_bot.dart';
import 'package:e_complaint_app/views/screens/form_aduan/form_aduan.dart';
import 'package:e_complaint_app/views/screens/mycomplaint/my_complaint_screen.dart';
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
import 'package:e_complaint_app/views/screens/notification/notification_screen.dart';
import 'package:e_complaint_app/views/screens/riwayat_aduan/riwayat_aduan.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static final Map<String, WidgetBuilder> routes = {
    '/login' : (context) => LoginScreen(),
    '/register' : (context) => RegisterScreen(),
    '/verifikasi_link' : (context) => VerifikasiLink(),
    '/verifikasi_otp' : (context) => VerifikasiOtp(),
    '/new_password' : (context) => NewPasswordScreen(),
    '/news' :(context) => NewsScreen(),
    '/forgot_password' : (context) => ForgotPasswordScreen(),
    '/notification' : (context) => NotificationScreen(),
    '/my_complaint' : (context) => MyComplaintScreen(),
    '/home' : (context) => const HomePageScreen(),
    '/change_profile_input' : (context) => const ChangeProfileInputScreen(),
    '/change_profile' : (context) => const ChangeProfileScreen(),
    '/profile' : (context) => const ProfileScreen(),
    '/form_aduan' : (context) => FormAduan(),
    '/riwayat_aduan' : (context) => RiwayatAduan(),
    '/chat_admin' :(context) => ChatAdmin(),
    '/chat_bot' :(context) => ChatBot(),
  
  };
}
