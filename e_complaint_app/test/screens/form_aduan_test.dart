import 'package:e_complaint_app/controllers/form_controller.dart';
import 'package:e_complaint_app/views/screens/form_aduan/components/date_picker.dart';
import 'package:e_complaint_app/views/screens/form_aduan/components/file_picker.dart';
import 'package:e_complaint_app/views/screens/form_aduan/form_aduan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Form Aduan Page UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FormAduanController()),
        ],
        child: MaterialApp(
          home: FormAduan(),
        ),
      ),
    );

    // Wait for the widgets to build
    await tester.pumpAndSettle();

    // Check if the main title is present
    expect(find.text('Formulir Aduan'), findsOneWidget);

    // Check if the fields are present
    expect(find.text('Lokasi'), findsOneWidget);
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    expect(find.text('Detail alamat ...'), findsOneWidget);
    expect(find.text('Generate Lokasi'), findsOneWidget);
    expect(find.byIcon(Icons.location_on), findsOneWidget);
    expect(find.text('Kategori Aduan'), findsOneWidget);
    expect(find.byType(DropdownButtonFormField<int>), findsOneWidget);
    expect(find.text('Isi Aduan'), findsOneWidget);
    expect(find.text('Ketik aduan ...'), findsOneWidget);
    expect(find.text('Jenis Aduan'), findsOneWidget);

    // Check if the buttons are present
    expect(find.text('Public'), findsOneWidget);
    expect(find.text('Private'), findsOneWidget);
    expect(find.text('Kirim'), findsOneWidget);

    // Check if the file picker is present
    expect(find.byType(FilePickerWidget), findsOneWidget);

    // Check if the date picker is present
    expect(find.byType(DatePickerWidget), findsOneWidget);
  });
}
