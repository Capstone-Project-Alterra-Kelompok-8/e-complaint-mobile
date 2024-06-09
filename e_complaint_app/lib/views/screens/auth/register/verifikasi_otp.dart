import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerifikasiOtp extends StatefulWidget {
  const VerifikasiOtp({super.key});

  @override
  State<VerifikasiOtp> createState() => _VerifikasiOtpState();
}

class _VerifikasiOtpState extends State<VerifikasiOtp> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: TextCollections.headingTwo.copyWith(
      color: ColorCollections.textPrimaryColor,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Color(0xFF00000),
          spreadRadius: 3,
          blurRadius: 4,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
  );

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
                  'Enter the verification code we just sent on your email address.',
                  textAlign: TextAlign.center,
                  style: LoginTextCollections.headingTwo,
                ),
                const Gap(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email OTP',
                    style: LoginTextCollections.headingOne.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
                const Gap(10),
                Pinput(
                  controller: pinController,
                  length: 5,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(
                            color: ColorCollections.buttonColor, width: 2)),
                  ),
                  onCompleted: (pin) => debugPrint(pin),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tidak menerima kode OTP?',
                      style: LoginTextCollections.headingTwo.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Kirim Ulang',
                        style: LoginTextCollections.headingTwo.copyWith(
                          color: const Color(0xFF29B6F6),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(30),
                SizedBox(
                  width: double.infinity,
                  height: 32,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorCollections.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        final registerAuthController =
                            Provider.of<RegisterAuthController>(context,
                                listen: false);

                        registerAuthController.verifyOtp(
                            context, email, pinController.text);
                      },
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          color: ColorCollections.textSecondaryColor,
                        ),
                      )),
                ),
                const Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
