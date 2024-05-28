import 'package:e_complaint_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.5),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 37),
                  child:Image.asset('assets/images/logo.png', width: 227, height: 227,),
                ),
                Text(
                  'Welcome',
                  style: LoginTextCollections.headingOne
                ),
                const SizedBox(height: 5),
                Text(
                  'Login to your account',
                  style: LoginTextCollections.headingTwo
                ),
                Gap(20),
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
                SizedBox(height: 10),
                 Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
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
                    controller: passwordController,
                    obscureText: isVisible!,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      hintText: 'Password',
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
                      icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                    },
                    child: Text(
                      'Forgot Password?',
                      style: LoginTextCollections.headingFour,
                    ),
                  ),
                ),
                Gap(30),
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
                    onPressed: (){}, 
                    child: Text(
                      'Login',
                      style: LoginTextCollections.headingThree,

                      
                    )),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have account?',
                      style: LoginTextCollections.headingFive,
                    ),
                    TextButton(
                      onPressed: () {
                      },
                      child: Text(
                        'Create Now',
                        style: LoginTextCollections.headingSix,
                      ),
                    ),
                  ],
                ),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     InkWell(
                      onTap: () {
                      },
                      child: SvgPicture.asset('assets/svg/google.svg', width: 30, height: 32),
                    ),
                    SizedBox(width: 10),
                     InkWell(
                      onTap: () {
                      },
                      child: SvgPicture.asset('assets/svg/instagram.svg', width: 30, height: 32),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                      },
                      child: SvgPicture.asset('assets/svg/devicon_facebook.svg', width: 30, height: 32),
                    ),
                    
                  ],
                )

                
              ],
            ),          
          ),
        ),
      )
    );
  }
}