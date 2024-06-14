import 'package:e_complaint_app/app_route.dart';
import 'package:e_complaint_app/controllers/auth_controller.dart';
import 'package:e_complaint_app/controllers/form_controller.dart';
import 'package:e_complaint_app/controllers/profile_controller.dart';
import 'package:e_complaint_app/views/screens/auth/login_screen.dart';
import 'package:e_complaint_app/views/screens/form_aduan/components/location.dart';
import 'package:e_complaint_app/views/screens/form_aduan/form_aduan.dart';
import 'package:e_complaint_app/views/screens/news/news_screen.dart';
import 'package:e_complaint_app/views/screens/home/profile_screen.dart';
import 'package:e_complaint_app/controllers/my_complaint_controller.dart';
import 'package:e_complaint_app/controllers/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterAuthController()),
        ChangeNotifierProvider(create: (context) => LoginAuthController()),
        ChangeNotifierProvider(create: (context) => ProfileController()),
        ChangeNotifierProvider(create: (context) => NewsController()),
        ChangeNotifierProvider(create: (context) => MyComplaintController()),
        ChangeNotifierProvider(create: (context) => NewsCommentController()),
        ChangeNotifierProvider(create: (context) => FormAduanController()),
        // ChangeNotifierProvider(create: (context) => LocationProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: AppRoute.routes,
      ),
    );
  }
}
