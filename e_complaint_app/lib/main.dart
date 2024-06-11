
import 'package:e_complaint_app/app_route.dart';
import 'package:e_complaint_app/controllers/my_complaint_controller.dart';
import 'package:e_complaint_app/controllers/news_controller.dart';
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
          ChangeNotifierProvider(create: (context) => NewsController()),
          ChangeNotifierProvider(create: (context) => MyComplaintController()),
    ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/my_complaint',
        routes: AppRoute.routes,
      ),
    );
  }
}