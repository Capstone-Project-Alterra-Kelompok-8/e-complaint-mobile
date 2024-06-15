import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/screens/auth/login_screen.dart';
import 'package:e_complaint_app/views/screens/home/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  final bool loggedIn;
  const SplashScreen({super.key, required this.loggedIn});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => widget.loggedIn ? const HomePageScreen() : const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
            width: 150,
            child: Image(image: AssetImage('assets/images/avatar.png'))),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: LoadingAnimationWidget.prograssiveDots(
              color: ColorCollections.primaryColor,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
