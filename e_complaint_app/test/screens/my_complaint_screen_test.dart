import 'dart:math';

import 'package:e_complaint_app/controllers/my_complaint_controller.dart';
import 'package:e_complaint_app/views/screens/mycomplaint/my_complaint_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Halaman menampilkan aduanku', (WidgetTester widgetTester) async {
    // Build our app and trigger a frame.
    await widgetTester.pumpWidget(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => MyComplaintController()),
      ],
        child: MaterialApp(
          home: MyComplaintScreen(),
        ),
      )
    );
   
   expect(find.byType(IconButton), findsWidgets);
    expect(find.byType(Text), findsWidgets);
    expect(find.byKey(Key('list_complaint')), findsOneWidget);
    
   
  });
}