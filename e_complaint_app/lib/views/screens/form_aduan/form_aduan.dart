import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/models/complaint_model.dart';
import 'package:e_complaint_app/services/complaint_service.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/form_aduan/popup_failed.dart';
import 'package:e_complaint_app/views/screens/form_aduan/popup_success.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

class FormAduan extends StatefulWidget {
  const FormAduan({Key? key}) : super(key: key);

  @override
  State<FormAduan> createState() => _FormAduanState();
}

class _FormAduanState extends State<FormAduan> {
  List<String?> _selectedImagePaths = [];
  String? _selectedLokasi;
  String? _selectedIsiAduan;
  int? _selectedKategoriAduan;
  DateTime _dueDate = DateTime.now();
  final _currentDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String? _jenisAduan;
  final TextEditingController _detailAlamatController = TextEditingController();
  final ComplaintService _complaintService = ComplaintService();
  List<Regency> _regencies = [];
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();

    _complaintService.setAuthToken(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM');

    _fetchRegencies();

    _fetchCategories();
  }

  void _fetchRegencies() async {
    try {
      List<Regency> regencies = await _complaintService.fetchRegencies();
      setState(() {
        _regencies = regencies;
      });
    } catch (e) {
      print('Error fetching regencies: $e');
    }
  }

  void _fetchCategories() async {
    try {
      List<Category> categories = await _complaintService.fetchCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedImagePaths.isNotEmpty) {
        try {
          final complaintData = {
            'regency_id': _selectedLokasi,
            'address': _detailAlamatController.text,
            'category_id': _selectedKategoriAduan,
            'description': _selectedIsiAduan,
            'type': _jenisAduan,
            'date': DateFormat("dd-MM-yyyy")
                .format(_dueDate), // Format the date correctly
            'files': _selectedImagePaths,
          };
          final response =
              await _complaintService.submitComplaint(complaintData);
          if (response.status) {
            print('Laporan berhasil: ${response.complaint?.id}');
            _showSuccessPopup();
          } else {
            print('Gagal mengirim aduan: ${response.message}');
            _showFailedPopup();
          }
        } catch (e) {
          print('Error submitting form: $e');
          _showFailedPopup();
        }
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

  Future<void> _generateLokasi() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _detailAlamatController.text =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });
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
                    items: _regencies
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
                    controller: _detailAlamatController,
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
                      onTap: _generateLokasi,
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
                            onPressed: _generateLokasi,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDatePicker(context),
                  const SizedBox(height: 12),
                  const Text(
                    'Kategori Aduan',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    value: _selectedKategoriAduan,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedKategoriAduan = newValue;
                      });
                    },
                    items: _categories
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
                    initialValue: _selectedIsiAduan,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      _selectedIsiAduan = value;
                    },
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
                              _jenisAduan = 'Publik';
                            });
                          },
                          child: Text(
                            'Publik',
                            style: TextStyle(
                              color: _jenisAduan == 'Publik'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _jenisAduan == 'Publik'
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
                              _jenisAduan = 'Private';
                            });
                          },
                          child: Text(
                            'Private',
                            style: TextStyle(
                              color: _jenisAduan == 'Private'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _jenisAduan == 'Private'
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
                        onPressed: _submitForm,
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
            if (_selectedImagePaths.length == 3 &&
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
                  borderRadius: BorderRadius.circular(8),
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
                            Text("Tambah Foto"),
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
            borderRadius: BorderRadius.circular(8),
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
                label: const Text("Pilih Tanggal"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
