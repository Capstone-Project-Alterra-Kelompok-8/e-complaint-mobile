import 'package:e_complaint_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class VerifikasiLink extends StatelessWidget {
  const VerifikasiLink({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 54, left: 22.5, right: 22.5),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 227,
                  height: 227,
                ),
                Text(
                  'Verification',
                  style: LoginTextCollections.headingOne,
                ),
                Text(
                  'Verify your email address',
                  textAlign: TextAlign.center,
                  style: LoginTextCollections.headingTwo,
                ),
                const Gap(40),
                Text(
                  'Welcome To KeluhProv!',
                  textAlign: TextAlign.center,
                  style: LoginTextCollections.headingTwo,
                ),
                const Gap(40),
                Text(
                  'please click the button below to confirm your email address and activate your account',
                  textAlign: TextAlign.center,
                  style: LoginTextCollections.headingTwo,
                ),
                const Gap(30),
                SizedBox(
                  width: 200,
                  height: 32,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorCollections.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/verifikasi_otp',
                          arguments: email,
                        );
                      },
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          color: ColorCollections.textSecondaryColor,
                        ),
                      )),
                ),
                const Gap(40),
                Text(
                  'if you received in this error, simply ignore this email and do not click the button',
                  textAlign: TextAlign.center,
                  style: LoginTextCollections.headingTwo
                      .copyWith(color: const Color(0xFF979797)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
