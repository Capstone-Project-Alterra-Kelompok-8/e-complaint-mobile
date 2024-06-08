import 'package:dio/dio.dart';
import 'dart:io';
import 'package:e_complaint_app/models/complaint_model.dart';

class ComplaintService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1';
  String _authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM';

  void setAuthToken(String token) {
    _authToken = token;
  }

  Future<MultipartFile> _convertFileToMultipartFile(String filePath) async {
    return await MultipartFile.fromFile(filePath,
        filename: filePath.split('/').last);
  }

  Future<Complaint> submitComplaint(Map<String, dynamic> complaintData) async {
    try {
      List<MultipartFile> files = [];
      for (String path in complaintData['files']) {
        files.add(await _convertFileToMultipartFile(path));
      }

      FormData formData = FormData.fromMap({
        'regency_id': complaintData['regency_id'],
        'address': complaintData['address'],
        'category_id': complaintData['category_id'],
        'description': complaintData['description'],
        'tanggal': complaintData['tanggal'],
        'type': complaintData['type'],
        'files': files,
      });

      print('Mengirim aduan dengan data: ${formData.fields}');

      final response = await _dio.post(
        '$_baseUrl/complaints',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_authToken',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Berhasil Membuat Laporan');
        print('Response: ${response.data}');
        return Complaint.fromJson(response.data['data']);
      } else {
        print(
            'Gagal mengirim aduan: ${response.statusCode} ${response.statusMessage}');
        throw Exception('Gagal mengirim aduan: ${response.statusMessage}');
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.response?.data}');
        print('Request: ${e.requestOptions.data}');
        print('Headers: ${e.requestOptions.headers}');
      }
      print('Gagal mengirim aduan: $e');
      throw Exception('Gagal mengirim aduan: $e');
    }
  }
}
