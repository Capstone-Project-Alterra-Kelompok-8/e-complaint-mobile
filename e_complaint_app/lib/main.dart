import 'package:e_complaint_app/views/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true,),
      home: const ProfileScreen(),
    );
  }
}
