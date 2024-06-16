import 'package:e_complaint_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:e_complaint_app/constants/constants.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool _isButtonEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = emailController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<RegisterAuthController>(context).isLoading;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 54, left: 22.5, right: 22.5),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 227,
                        width: 227,
                      ),
                    ),
                    Center(
                      child: Text(
                        'Lupa Password',
                        style: LoginTextCollections.headingOne,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Masukan email kamu untuk\n langkah lupa password',
                        textAlign: TextAlign.center,
                        style: LoginTextCollections.headingTwo,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: LoginTextCollections.headingThree,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(16),
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: _isButtonEnabled
                            ? ElevatedButton.styleFrom(
                                backgroundColor: ColorCollections.buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              )
                            : ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                        onPressed: _isButtonEnabled ? () async {
                            if (_formKey.currentState?.validate() ?? false) {
                          final registerAuthController =
                              Provider.of<RegisterAuthController>(context,
                                  listen: false);
                          await registerAuthController.sendOtpForgotPassword(
                              context, emailController.text);
                        }} : null,
                        child: _isButtonEnabled
                            ? Text(
                                'Kirim kode',
                                style: TextStyle(
                                  color: ColorCollections.textSecondaryColor,
                                ),
                              )
                            : const Text(
                                'Kirim kode',
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.w700),
                              ),
                      ),
                    ),
                  ],
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
