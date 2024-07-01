import 'package:e_complaint_app/views/screens/news/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:e_complaint_app/controllers/news_controller.dart'; // Import the NewsController

void main() {
  testWidgets('NewsScreen UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NewsController()),
        ],
        child: const MaterialApp(
          home: NewsScreen(),
        ),
      ),
    );

    expect(find.text('Berita Terbaru'), findsWidgets);
    expect(find.text('Berita Lainnya'), findsOneWidget);
  });
}
