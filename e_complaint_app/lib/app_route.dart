import 'package:e_complaint_app/views/screens/aduanku/aduanku_screen.dart';
import 'package:e_complaint_app/views/screens/aduanku/detail_aduanku_screeen.dart';
import 'package:e_complaint_app/views/screens/aduanku/progress_aduanku_screen.dart';
import 'package:e_complaint_app/views/screens/auth/create_new_password_screen.dart';
import 'package:e_complaint_app/views/screens/auth/forget_password_screen.dart';
import 'package:e_complaint_app/views/screens/auth/login_screen.dart';
import 'package:e_complaint_app/views/screens/auth/register/register.dart';
import 'package:e_complaint_app/views/screens/auth/register/verifikasi_link.dart';
import 'package:e_complaint_app/views/screens/auth/register/verifikasi_otp.dart';
import 'package:e_complaint_app/views/screens/customer_services/chat_admin.dart';
import 'package:e_complaint_app/views/screens/form_aduan/form_aduan.dart';
import 'package:e_complaint_app/views/screens/home/aboutapp_screen.dart';
import 'package:e_complaint_app/views/screens/home/chanepassword_screen.dart';
import 'package:e_complaint_app/views/screens/home/changeprofile_screen.dart';
import 'package:e_complaint_app/views/screens/home/homepage_screen.dart';
import 'package:e_complaint_app/views/screens/home/profile_screen.dart';
import 'package:e_complaint_app/views/screens/news/news_screen.dart';
import 'package:e_complaint_app/views/screens/news/components/news_detail.dart';
import 'package:e_complaint_app/views/screens/notification/notification_screen.dart';
import 'package:e_complaint_app/views/screens/riwayat_aduan/riwayat_aduan.dart';
import 'package:flutter/material.dart';




class AppRoute {
  static final Map<String, WidgetBuilder> routes = {

    //AUTH
    '/login' : (context) => LoginScreen(),
    '/register' : (context) => RegisterScreen(),

    // HOME 
    '/homepage' : (context) => HomePageScreen(),
    '/profile' : (context) => ProfileScreen(),
    '/change_password_profile' : (context) => ChangePasswordProfileScreen(),
    '/aboutApp' : (context) => AboutAppScreen(),
    '/change_profile' : (context) => ChangeProfileScreen(),
    '/verifikasi_link' : (context) => VerifikasiLink(),
    '/verifikasi_otp' : (context) => VerifikasiOtp(),
    '/new_password' : (context) => NewPasswordScreen(),
    '/news' :(context) => NewsScreen(),
    '/news_detail' : (context) => NewsDetail(),
    '/forgot_password' : (context) => ForgotPasswordScreen(),
    '/notification' : (context) => NotificationScreen(),
    '/detail_aduanku' : (context) => DetailAduankuScreen(),
    '/progress_aduanku' :(context) => ProgressAduankuScreen(),
    '/aduanku' :(context) => AduankuScreen(),
    '/riwayat_aduanku' : (context) => RiwayatAduan(),
    '/chat_admin' : (context) => ChatAdmin(),
    '/chat_bot' :(context) => ChatAdmin(),
    '/form_aduanku' : (context) => FormAduan(),
    
  };
  
}