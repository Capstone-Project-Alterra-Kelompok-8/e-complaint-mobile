import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:flutter/material.dart';

class ChangePasswordProfileScreen extends StatefulWidget {
  const ChangePasswordProfileScreen({super.key});

  @override
  State<ChangePasswordProfileScreen> createState() => _ChangePasswordProfileScreenState();
}

class _ChangePasswordProfileScreenState extends State<ChangePasswordProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Membuat kata sandi membantu Anda menjaga keamanan akun dan data di KeluhProv', style: HomeTextCollections.descriptionChangePassword,
              textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}