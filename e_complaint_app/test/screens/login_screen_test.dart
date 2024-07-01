import 'package:e_complaint_app/controllers/auth_controller.dart';
import 'package:e_complaint_app/views/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';


void main() {
  testWidgets('LoginScreen UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginAuthController()),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    expect(find.text('Email'), findsWidgets);
    expect(find.text('Password'), findsWidgets);
    expect(find.byType(TextFormField), findsWidgets);
  });
}
