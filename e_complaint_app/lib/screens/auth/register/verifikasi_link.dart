import 'package:flutter/material.dart';

class VerifikasiLink extends StatelessWidget {
  const VerifikasiLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Logo SVG
            Image.asset(
              'assets/logo.png',
              height: 200,
            ),
            const SizedBox(height: 20),
            // Text 'Register'
            const Text(
              'Verification',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Verify your email address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'please click the button below to confirm your email address and activate your account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Register Button
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Handle register logic
                  Navigator.pushNamed(context, '/register/register');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFEAB308),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  child: Text(
                    'Verify',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'if you received in this error, simply ignore this email and do not click the button',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
