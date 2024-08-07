import 'package:e_complaint_app/views/screens/auth/otp_forgot_password_verify_screen.dart';
import 'package:e_complaint_app/views/screens/auth/success_fotgot_password_screen.dart';
import 'package:e_complaint_app/views/screens/auth/splashscreen.dart';
import 'package:e_complaint_app/views/screens/chat_admin/chat_admin_screen.dart';
import 'package:e_complaint_app/views/screens/chat_ai/chat_ai_screen.dart';
import 'package:e_complaint_app/views/screens/form_aduan/form_aduan.dart';
import 'package:e_complaint_app/views/screens/home/aboutapp_screen.dart';
import 'package:e_complaint_app/views/screens/home/chanepassword_screen.dart';
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
    '/verifikasi_otp_forgot_password' : (context) => VerifikasiOtpForgotPassword(),
    '/new_password' : (context) => NewPasswordScreen(),
    '/change_password_profile' : (context) => ChangePasswordProfileScreen(),
    '/news' :(context) => NewsScreen(),
    '/forgot_password' : (context) => ForgotPasswordScreen(),
    '/notification' : (context) => NotificationScreen(),
    '/my_complaint' : (context) => MyComplaintScreen(),
    '/home' : (context) => const HomePageScreen(),
    '/change_profile_input' : (context) => const ChangeProfileInputScreen(),
    '/change_profile' : (context) => const ChangeProfileScreen(),
    '/profile' : (context) => const ProfileScreen(),
    '/form_aduan' : (context) => FormAduan(),
    '/riwayat_aduan' : (context) => RiwayatAduan(initialSegment: 0,),
    '/chat_admin' :(context) => ChatAdmin(),
    '/success_forgot_password' : (context) => SuccessForgotPasswordScreen(),
    '/chat_bot' :(context) => ChatBot(),
    '/about_App' : (context) => AboutAppScreen(),
    '/riwayat_favorit' : (context) => RiwayatAduan(initialSegment: 3)
  
  };
}
