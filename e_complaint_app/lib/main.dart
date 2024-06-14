import 'package:e_complaint_app/app_route.dart';
import 'package:e_complaint_app/controllers/auth_controller.dart';
import 'package:e_complaint_app/controllers/user_controller.dart';
import 'package:e_complaint_app/controllers/profile_controller.dart';
import 'package:e_complaint_app/controllers/my_complaint_controller.dart';
import 'package:e_complaint_app/controllers/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  runApp(MyApp(initialRoute: token == null ? '/login' : '/home'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterAuthController()),
        ChangeNotifierProvider(create: (context) => LoginAuthController()),
        ChangeNotifierProvider(create: (context) => ProfileController()),
        ChangeNotifierProvider(create: (context) => UserController()),
        ChangeNotifierProvider(create: (context) => NewsController()),
        ChangeNotifierProvider(create: (context) => MyComplaintController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: initialRoute,
        routes: AppRoute.routes,
      ),
    );
  }
}
