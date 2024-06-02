import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/form_aduan/popup_failed.dart';
import 'package:e_complaint_app/views/screens/form_aduan/popup_success.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class FormAduan extends StatefulWidget {
  const FormAduan({Key? key}) : super(key: key);

  @override
  State<FormAduan> createState() => _FormAduanState();
}

class _FormAduanState extends State<FormAduan> {
  List<String?> _selectedImagePaths = [];
  String? _selectedLokasi;
  String? _selectedDetailAlamat;
  String? _selectedJenisAduan;
  String? _selectedIsiAduan;
  String? _selectedKategoriAduan;
  DateTime _dueDate = DateTime.now();
  final _currentDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedImagePaths.isNotEmpty) {
        _showSuccessPopup();
      } else {
        _showFailedPopup();
      }
    } else {
      _showFailedPopup();
    }
  }

  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupSuccess();
      },
    );
  }

  void _showFailedPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupFailed();
      },
    );
  }

  void _pickFile(int index) async {
    if (_selectedImagePaths.length >= 5) {
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result == null) return;

    final file = result.files.first;
    setState(() {
      if (_selectedImagePaths.length > index) {
        _selectedImagePaths[index] = file.path;
      } else {
        _selectedImagePaths.add(file.path);
      }
    });
  }

  void _openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorCollections.profileColor,
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilePicker(context),
                  const SizedBox(height: 12),
                  const Text(
                    'Lokasi',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedLokasi,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLokasi = newValue;
                      });
                    },
                    items: <String>[
                      'Lokasi 1',
                      'Lokasi 2',
                      'Lokasi 3',
                      'Lokasi 4'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) =>
                        value == null ? 'Lokasi tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Detail Alamat',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _selectedDetailAlamat,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      _selectedDetailAlamat = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Detail Alamat tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Jenis Aduan',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedJenisAduan,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedJenisAduan = newValue;
                      });
                    },
                    items: <String>[
                      'Jenis Aduan 1',
                      'Jenis Aduan 2',
                      'Jenis Aduan 3',
                      'Jenis Aduan 4'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) =>
                        value == null ? 'Jenis Aduan tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 12),
                  _buildDatePicker(context),
                  const SizedBox(height: 12),
                  const Text(
                    'Isi Aduan',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _selectedIsiAduan,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      _selectedIsiAduan = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Isi Aduan tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Kategori Aduan',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedKategoriAduan,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedKategoriAduan = newValue;
                      });
                    },
                    items: <String>[
                      'Kategori Aduan 1',
                      'Kategori Aduan 2',
                      'Kategori Aduan 3',
                      'Kategori Aduan 4'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) => value == null
                        ? 'Kategori Aduan tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                        onPressed: _submitForm,
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorCollections.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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

  Widget _buildFilePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Dokumentasi',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(_selectedImagePaths.length + 1, (index) {
            if (_selectedImagePaths.length == 5 &&
                index == _selectedImagePaths.length) {
              return SizedBox.shrink();
            }
            return GestureDetector(
              onTap: () => _pickFile(index),
              child: Container(
                width: 115,
                height: 115,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: _selectedImagePaths.length > index &&
                          _selectedImagePaths[index] != null
                      ? Image.file(
                          File(_selectedImagePaths[index]!),
                          fit: BoxFit.cover,
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.image,
                              size: 30,
                            ),
                            SizedBox(height: 10),
                            Text("Upload"),
                          ],
                        ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tanggal',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat("dd-MM-yyyy").format(_dueDate),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _currentDate,
                    firstDate: DateTime(1990),
                    lastDate: DateTime(_currentDate.year + 10),
                  );

                  setState(() {
                    if (selectedDate != null) {
                      _dueDate = selectedDate;
                    }
                  });
                },
                icon: const Icon(Icons.date_range),
                label: const Text("Select"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
