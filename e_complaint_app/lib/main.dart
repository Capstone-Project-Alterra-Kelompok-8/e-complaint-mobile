import 'package:e_complaint_app/app_route.dart';
import 'package:e_complaint_app/controllers/auth_controller.dart';
import 'package:e_complaint_app/controllers/form_controller.dart';
import 'package:e_complaint_app/controllers/riwayat_aduan_controller.dart';
import 'package:e_complaint_app/controllers/user_controller.dart';
import 'package:e_complaint_app/controllers/profile_controller.dart';
import 'package:e_complaint_app/controllers/my_complaint_controller.dart';
import 'package:e_complaint_app/controllers/news_controller.dart';
import 'package:e_complaint_app/views/screens/auth/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  bool loggedIn = token != null;

  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;

  const MyApp({super.key, required this.loggedIn});

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
        ChangeNotifierProvider(create: (context) => FormAduanController()),
        ChangeNotifierProvider(create: (context) => NewsCommentController()),
        ChangeNotifierProvider(create: (context) => RiwayatAduanController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: SplashScreen(
            loggedIn: loggedIn), // Set SplashScreen as the initial screen
        routes: AppRoute.routes,
      ),
    );
  }
}
