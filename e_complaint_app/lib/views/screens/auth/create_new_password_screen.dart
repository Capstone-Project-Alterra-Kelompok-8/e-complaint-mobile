import 'package:e_complaint_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_complaint_app/constants/constants.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isButtonEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscured = true;
  bool _isObscuredConfirm = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  void _togglePasswordVisibilityConfirm() {
    setState(() {
      _isObscuredConfirm = !_isObscuredConfirm;
    });
  }

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled =
          passwordController.text == confirmPasswordController.text &&
              passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 54, left: 22.5, right: 22.5),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 227,
                    height: 227,
                    child: Center(
                        child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.fill,
                    )),
                  ),
                  Text('Ganti Password',
                      style: LoginTextCollections.headingOne),
                  Text(
                    'Ganti password kamu',
                    style: LoginTextCollections.headingTwo,
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password Baru',
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
                      controller: passwordController, // Link the controller
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        hintText: 'Kata Sandi Baru',
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      obscureText: _isObscured,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Konfirmasi Password',
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
                      controller:
                          confirmPasswordController, // Link the controller
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        hintText: 'Konfirmasi Kata Sandi Baru',
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscuredConfirm
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: _togglePasswordVisibilityConfirm,
                        ),
                      ),
                      obscureText: _isObscuredConfirm,
                    ),
                  ),
                  const SizedBox(
                    height: 43.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled
                          ? () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                final userController =
                                    Provider.of<RegisterAuthController>(context,
                                        listen: false);
                                await userController
                                    .changePasswordForgotPassword(
                                        context, passwordController.text);
                              }
                            }
                          : null,
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
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                          color:
                              _isButtonEnabled ? Colors.white : Colors.purple,
                          fontWeight: _isButtonEnabled
                              ? FontWeight.w500
                              : FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
