import 'package:e_complaint_app/controllers/chatBot_controller.dart';
import 'package:e_complaint_app/views/screens/chat_ai/chat_ai_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('ChatBot Page UI Test', (WidgetTester tester) async {
    
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ChatBotController()),
        ],
        child: MaterialApp(
          home: ChatBot(),
        ),
      ),
    );

    expect(find.text('Bot'), findsOneWidget);
    expect(find.text('Aktif sekarang'), findsOneWidget);

    expect(find.text('Hari ini'), findsOneWidget);
    expect(find.text('Hai, Aku Kava (KeluhProv AI Virtual Assistant)'), findsOneWidget);
    expect(find.text('Bantu KAVA agar bisa memberikan solusi yang tepat & cepat supaya bisa kami bantu secepatnya'), findsOneWidget);
  });
}
