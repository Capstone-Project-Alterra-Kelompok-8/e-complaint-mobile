import 'package:e_complaint_app/views/screens/riwayat_aduan/components/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Filter Widget UI Test', (WidgetTester tester) async {
    String selectedCategory = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Filter(
            initialCategory: 'Kesehatan',
            onCategorySelected: (category) {
              selectedCategory = category;
            },
          ),
        ),
      ),
    );

    // Check if the Filter title is present
    expect(find.text('Filter'), findsOneWidget);

    // Check if the categories are present
    expect(find.text('Pilih Kategori'), findsOneWidget);
    expect(find.text('Kesehatan'), findsOneWidget);
    expect(find.text('Pendidikan'), findsOneWidget);
    expect(find.text('Kependudukan'), findsOneWidget);
    expect(find.text('Keamanan'), findsOneWidget);
    expect(find.text('Infrastruktur'), findsOneWidget);
    expect(find.text('Transportasi'), findsOneWidget);
    expect(find.text('Sosial'), findsOneWidget);

    // Select a category and verify the callback
    await tester.tap(find.text('Pendidikan'));
    await tester.pumpAndSettle();
    expect(selectedCategory, 'Pendidikan');
  });
}
