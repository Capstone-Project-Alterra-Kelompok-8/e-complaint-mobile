import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifikasiOtpForgotPassword extends StatefulWidget {
  const VerifikasiOtpForgotPassword({super.key});

  @override
  State<VerifikasiOtpForgotPassword> createState() =>
      _VerifikasiOtpForgotPasswordState();
}

class _VerifikasiOtpForgotPasswordState
    extends State<VerifikasiOtpForgotPassword> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    pinController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = pinController.text.isNotEmpty;
    });
  }

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
    final isLoading = Provider.of<RegisterAuthController>(context).isLoading;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 54, left: 22.5, right: 22.5),
              child: Center(
                child: Form(
                  key: _formKey,
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
                        'Verifikasi',
                        style: LoginTextCollections.headingOne,
                      ),
                      Text(
                        'Masukkan kode verifikasi yang baru\nsaja kami kirimkan ke alamat email\nAnda.',
                        textAlign: TextAlign.center,
                        style: HomeTextCollections.descOtp,
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
                                  color: ColorCollections.buttonColor,
                                  width: 2)),
                        ),
                        onCompleted: (pin) => debugPrint(pin),
                      ),
                      const Gap(10),
                      Container(
                        height: 70,
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('* Tidak menerima kode OTP?',
                                    style: HomeTextCollections.bottomDescOtp),
                                TextButton(
                                  onPressed: () async {
                                    final sendOtpController =
                                        Provider.of<RegisterAuthController>(
                                            context,
                                            listen: false);
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    final email =
                                        prefs.getString('email') ?? '';

                                    await sendOtpController
                                        .sendOtpForgotPassword(context, email);
                                  },
                                  child: Text(
                                    'Kirim Ulang',
                                    style: HomeTextCollections.bottomDescOtp
                                        .copyWith(
                                      color: const Color(0xFF29B6F6),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Transform.translate(
                              offset:
                                  Offset(0, -15), // Adjust the offset as needed
                              child: Text(
                                  '* Masukan Kode OTP dalam waktu 60 Detik',
                                  style: HomeTextCollections.bottomDescOtp),
                            ),
                          ],
                        ),
                      ),
                      const Gap(30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: _isButtonEnabled
                              ? ElevatedButton.styleFrom(
                                  backgroundColor: ColorCollections.buttonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                )
                              : ElevatedButton.styleFrom(
                                  backgroundColor:
                                      ColorCollections.disableAuthButtonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                          onPressed: _isButtonEnabled
                              ? () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final registerAuthController =
                                        Provider.of<RegisterAuthController>(
                                            context,
                                            listen: false);
                                    await registerAuthController
                                        .verifyOtpForgotPassword(
                                            context, pinController.text);
                                  }
                                }
                              : null,
                          child: _isButtonEnabled
                              ? const Text(
                                  'Verify',
                                  style: TextStyle(
                                    color: ColorCollections.textSecondaryColor,
                                  ),
                                )
                              : const Text(
                                  'Verify',
                                  style: TextStyle(
                                    color:
                                        ColorCollections.disableButtonTextColor,
                                  ),
                                ),
                        ),
                      ),
                      const Gap(40),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: SizedBox(
                  width: 70.0,
                  height: 70.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                    backgroundColor: Colors.white,
                    strokeWidth: 7.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
