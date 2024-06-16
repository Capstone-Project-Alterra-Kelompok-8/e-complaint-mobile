import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/user_controller.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordProfileScreen extends StatefulWidget {
  const ChangePasswordProfileScreen({super.key});

  @override
  State<ChangePasswordProfileScreen> createState() =>
      _ChangePasswordProfileScreenState();
}

class _ChangePasswordProfileScreenState
    extends State<ChangePasswordProfileScreen> {
  bool _isObscured = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatNewPasswordController = TextEditingController();

  bool get _isButtonEnabled {
    return newPasswordController.text.isNotEmpty &&
        repeatNewPasswordController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    newPasswordController.addListener(_updateButtonState);
    repeatNewPasswordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    newPasswordController.removeListener(_updateButtonState);
    newPasswordController.dispose();
    repeatNewPasswordController.removeListener(_updateButtonState);
    repeatNewPasswordController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    final isLoading = Provider.of<UserController>(context).isLoading;
    return Scaffold(
      appBar: const CurvedAppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Membuat kata sandi membantu Anda menjaga keamanan akun dan data di KeluhProv',
                    style: HomeTextCollections.descriptionChangePassword,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Masukan Kata Sandi Baru',
                      style: HomeTextCollections.titleButtonChangePassword,
                    ),
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
                    child: TextField(
                      controller: newPasswordController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        hintText: 'Masukan Kata Sandi Baru',
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
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Masukan Ulang Kata Sandi Baru',
                      style: HomeTextCollections.titleButtonChangePassword,
                    ),
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
                    child: TextField(
                      controller: repeatNewPasswordController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        hintText: 'Masukan Ulang Kata Sandi Baru',
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
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: _isButtonEnabled
                            ? () async {
                                await userController.changePassword(
                                    context,
                                    newPasswordController.text,
                                    repeatNewPasswordController.text);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isButtonEnabled
                              ? ColorCollections.buttonColor
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: _isButtonEnabled
                            ? Text(
                                'Buat Kata Sandi',
                                style: HomeTextCollections
                                    .enableSubmitButtonChangePassword,
                              )
                            : Text(
                                'Buat Kata Sandi',
                                style: HomeTextCollections
                                    .disableSubmitButtonChangePassword,
                              )),
                  ),
                ],
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
