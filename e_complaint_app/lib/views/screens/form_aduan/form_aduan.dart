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
  String? _selectedImagePath;
  String? _selectedLokasi;
  String? _selectedAduanType;
  String? _selectedAduanCategory;
  DateTime _dueDate = DateTime.now();
  final _currentDate = DateTime.now();

  void _submitForm() {
    if (_selectedImagePath == null ||
        _selectedLokasi == null ||
        _selectedAduanType == null ||
        _selectedAduanCategory == null) {
      _showFailedPopup();
      return;
    }

    _showSuccessPopup();
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

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    debugPrint(result.toString());
    if (result == null) return;

    final file = result.files.first;
    setState(() {
      _selectedImagePath = file.path;
    });
  }

  void _openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(),
      body: ListView(
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
                        style: TextStyle(
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
                ),
                const SizedBox(height: 12),
                const Text(
                  'Detail Alamat',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Jenis Aduan',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedAduanType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedAduanType = newValue;
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
                        style: TextStyle(
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
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Kategori Aduan',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedAduanCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedAduanCategory = newValue;
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
                        style: TextStyle(
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
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: Offset(3, 3),
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
    );
  }

  Widget _buildFilePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Dokumentasi',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: _selectedImagePath == null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.image,
                          size: 30,
                        ),
                        SizedBox(height: 20),
                        Text("Upload a file or drag and drop"),
                      ],
                    )
                  : Image.file(
                      File(_selectedImagePath!),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
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
