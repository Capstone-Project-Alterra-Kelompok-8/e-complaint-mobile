import 'package:e_complaint_app/models/form_aduan_model.dart' as form_aduan;
import 'package:e_complaint_app/models/form_aduan_model.dart';
import 'package:e_complaint_app/services/form_service.dart';
import 'package:e_complaint_app/views/screens/form_aduan/components/popup_failed.dart';
import 'package:e_complaint_app/views/screens/form_aduan/components/popup_success.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class FormAduanController extends ChangeNotifier {
  final ComplaintService _complaintService = ComplaintService();
  final TextEditingController detailAlamatController = TextEditingController();
  final TextEditingController isiAduanController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String?> selectedImagePaths = [];
  String? selectedLokasi;
  int? selectedKategoriAduan;
  DateTime dueDate = DateTime.now();
  final DateTime currentDate = DateTime.now();
  String? jenisAduan;
  List<form_aduan.Regency> regencies = [];
  List<form_aduan.Category> categories = [];

  BuildContext? context;

  FormAduanController({this.context}) {
    fetchRegencies();
    fetchCategories();
  }

  Future<void> fetchRegencies() async {
    try {
      regencies = await _complaintService.fetchRegencies();
      notifyListeners();
    } catch (e) {
      print('Error fetching regencies: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      categories = await _complaintService.fetchCategories();
      notifyListeners();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      if (selectedImagePaths.isNotEmpty) {
        try {
          final response = await submitComplaint();
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

  Future<ComplaintResponse> submitComplaint() async {
    try {
      final complaintData = {
        'regency_id': selectedLokasi,
        'address': detailAlamatController.text,
        'category_id': selectedKategoriAduan,
        'description': isiAduanController.text,
        'type': jenisAduan,
        'date': DateFormat("dd-MM-yyyy").format(dueDate),
        'files': selectedImagePaths,
      };
      return await _complaintService.submitComplaint(complaintData);
    } catch (e) {
      print('Error submitting complaint: $e');
      return ComplaintResponse(
          status: false, message: 'Failed to submit complaint: $e');
    }
  }

  void _showSuccessPopup() {
    if (context != null) {
      showDialog(
        context: context!,
        builder: (BuildContext context) {
          return PopupSuccess();
        },
      );
    }
  }

  void _showFailedPopup() {
    if (context != null) {
      showDialog(
        context: context!,
        builder: (BuildContext context) {
          return PopupFailed();
        },
      );
    }
  }

  Future<void> pickFile(int index) async {
    if (selectedImagePaths.length >= 5) {
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result == null) return;

    final file = result.files.first;
    if (selectedImagePaths.length > index) {
      selectedImagePaths[index] = file.path;
    } else {
      selectedImagePaths.add(file.path);
    }
    notifyListeners();
  }

  Future<void> generateLokasi() async {
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
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      detailAlamatController.text =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    } else {
      detailAlamatController.text = 'Location not found';
    }
    notifyListeners();
  }
}
