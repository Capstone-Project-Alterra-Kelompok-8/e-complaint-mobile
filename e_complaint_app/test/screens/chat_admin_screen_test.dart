// test/chat_admin_test.dart

import 'package:e_complaint_app/controllers/chatAdmin_controller.dart';
import 'package:e_complaint_app/views/screens/chat_admin/chat_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('ChatAdmin Page UI Test', (WidgetTester tester) async {
    
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ChatAdminController()),
        ],
        child: MaterialApp(
          home: ChatAdmin(),
        ),
      ),
    );
    
    expect(find.text('Admin'), findsOneWidget);
    expect(find.text('Aktif sekarang'), findsOneWidget);
    expect(find.text('Hari ini'), findsOneWidget);
    
    
  });
}
