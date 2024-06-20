import 'package:e_complaint_app/constants/constants.dart';
import 'package:flutter/material.dart';

class SuccessForgotPasswordScreen extends StatefulWidget {
  const SuccessForgotPasswordScreen({super.key});

  @override
  State<SuccessForgotPasswordScreen> createState() =>
      _SuccessForgotPasswordScreenState();
}

class _SuccessForgotPasswordScreenState
    extends State<SuccessForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 234, left: 23, right: 23),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Ganti Password', style: LoginTextCollections.headingOne),
                Text(
                  'Ganti password kamu',
                  style: LoginTextCollections.headingTwo,
                ),
                SizedBox(
                  height: 43,
                ),
                Image.asset(
                  'assets/images/successmark.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Kata Sandi diubah!',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
                const Text('Kata sandi anda telah'),
                const Text('berhasil diubah.'),
                const SizedBox(height: 35),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorCollections.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Kembali ke masuk',
                      style: TextStyle(
                        color: ColorCollections.textSecondaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
