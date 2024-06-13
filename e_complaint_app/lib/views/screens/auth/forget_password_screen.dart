import 'package:flutter/material.dart';
import 'package:e_complaint_app/constants/constants.dart';




class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 54, left: 22.5, right: 22.5),
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
                  'Forgot Password',
                  style: LoginTextCollections.headingOne,
                ),
              ),
              const SizedBox(height: 10),
              
              Center(
                child: Text(
                  'Enter your registered email below to receive password reset instruction',
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
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorCollections.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),                      
                        ),
                       
                      ),
                    onPressed: (){
                      Navigator.pushNamed(context, '/new_password');
                    }, 
                    child: const Text(
                      'Send Code',
                      style: TextStyle(
                        color: ColorCollections.textSecondaryColor,
                      ),
                    )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
