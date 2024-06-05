
import 'package:e_complaint_app/app_route.dart';
import 'package:e_complaint_app/controllers/auth_controller.dart';
import 'package:e_complaint_app/views/screens/auth/login_screen.dart';
import 'package:e_complaint_app/views/screens/news/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => RegisterAuthController()),
    ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/register',
        routes: AppRoute.routes,
      ),
    );
  }
}