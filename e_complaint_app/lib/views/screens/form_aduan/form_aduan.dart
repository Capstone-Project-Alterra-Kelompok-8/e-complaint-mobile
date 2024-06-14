import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/form_controller.dart';
import 'package:e_complaint_app/models/form_aduan_model.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/form_aduan/components/date_picker.dart';
import 'package:e_complaint_app/views/screens/form_aduan/components/file_picker.dart';
import 'package:flutter/material.dart';

class FormAduan extends StatefulWidget {
  const FormAduan({Key? key}) : super(key: key);

  @override
  State<FormAduan> createState() => _FormAduanState();
}

class _FormAduanState extends State<FormAduan> {
  final FormAduanController _controller = FormAduanController();

  @override
  void initState() {
    super.initState();
    _controller.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(),
      body: Form(
        key: _controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Center(
                child: Text(
                  'Formulir Aduan',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorCollections.secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilePickerWidget(
                    selectedImagePaths: _controller.selectedImagePaths,
                    onPickFile: (index) => setState(() {
                      _controller.pickFile(index);
                    }),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Lokasi',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _controller.selectedLokasi,
                    onChanged: (newValue) {
                      setState(() {
                        _controller.selectedLokasi = newValue;
                      });
                    },
                    items: _controller.regencies
                        .map<DropdownMenuItem<String>>((Regency regency) {
                      return DropdownMenuItem<String>(
                        value: regency.id,
                        child: Text(
                          regency.name,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: 'Kota/Kabupaten',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) =>
                        value == null ? 'Lokasi tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _controller.detailAlamatController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Detail alamat ...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Detail Alamat tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _controller.generateLokasi,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Generate Lokasi',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.location_on,
                                color: Colors.blue),
                            onPressed: _controller.generateLokasi,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DatePickerWidget(
                    dueDate: _controller.dueDate,
                    currentDate: _controller.currentDate,
                    onDateChanged: (newDate) {
                      setState(() {
                        _controller.dueDate = newDate;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Kategori Aduan',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    value: _controller.selectedKategoriAduan,
                    onChanged: (newValue) {
                      setState(() {
                        _controller.selectedKategoriAduan = newValue;
                      });
                    },
                    items: _controller.categories
                        .map<DropdownMenuItem<int>>((Category category) {
                      return DropdownMenuItem<int>(
                        value: category.id,
                        child: Text(
                          category.name,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: 'Kategori aduan',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) => value == null
                        ? 'Kategori Aduan tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Isi Aduan',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _controller.isiAduanController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Ketik aduan ...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Isi Aduan tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Jenis Aduan',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _controller.jenisAduan = 'Publik';
                            });
                          },
                          child: Text(
                            'Publik',
                            style: TextStyle(
                              color: _controller.jenisAduan == 'Publik'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _controller.jenisAduan == 'Publik'
                                ? ColorCollections.buttonColor
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _controller.jenisAduan = 'Private';
                            });
                          },
                          child: Text(
                            'Private',
                            style: TextStyle(
                              color: _controller.jenisAduan == 'Private'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _controller.jenisAduan == 'Private'
                                ? ColorCollections.buttonColor
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _controller.submitForm,
                        child: const Text(
                          'Kirim',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorCollections.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
