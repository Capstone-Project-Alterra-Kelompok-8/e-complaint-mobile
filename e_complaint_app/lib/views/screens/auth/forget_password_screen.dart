import 'package:flutter/material.dart';
import 'package:e_complaint_app/constants/constants.dart';




class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
              SizedBox(height: 20),
              
              Center(
                child: Text(
                  'Forgot Password',
                  style: LoginTextCollections.headingOne,
                ),
              ),
              SizedBox(height: 10),
              
              Center(
                child: Text(
                  'Enter your registered email below to receive password reset instruction',
                  textAlign: TextAlign.center,
                  style: LoginTextCollections.headingTwo,
                ),
              ),
              SizedBox(height: 20),
              
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 20),
              
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/new_password');
                    
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorCollections.textSecondaryColor,
                    backgroundColor: ColorCollections.buttonColor, 
                    shadowColor: Colors.black54,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 2.0,
                        left: 2.0,
                        child: Container(
                          width: 120.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Send Code',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorCollections.textSecondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
