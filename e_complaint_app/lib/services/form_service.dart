import 'package:dio/dio.dart';
import 'package:e_complaint_app/models/form_aduan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1';

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<Regency>> fetchRegencies() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await _dio.get(
        '$_baseUrl/regencies',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => Regency.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load regencies');
      }
    } catch (e) {
      throw Exception('Failed to load regencies: $e');
    }
  }

  Future<List<Category>> fetchCategories() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await _dio.get(
        '$_baseUrl/categories',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<MultipartFile> _convertFileToMultipartFile(String filePath) async {
    return await MultipartFile.fromFile(filePath,
        filename: filePath.split('/').last);
  }

  Future<ComplaintResponse> submitComplaint(
      Map<String, dynamic> complaintData) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      List<MultipartFile> files = [];
      for (String path in complaintData['files']) {
        files.add(await _convertFileToMultipartFile(path));
      }

      FormData formData = FormData.fromMap({
        'regency_id': complaintData['regency_id'],
        'address': complaintData['address'],
        'category_id': complaintData['category_id'],
        'description': complaintData['description'],
        'date': complaintData['date'],
        'type': complaintData['type'],
        'files': files,
      });

      print('Mengirim aduan dengan data: ${formData.fields}');

      final response = await _dio.post(
        '$_baseUrl/complaints',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Berhasil Membuat Laporan');
        print('Response: ${response.data}');
        return ComplaintResponse.fromJson(response.data);
      } else {
        print(
            'Gagal mengirim aduan: ${response.statusCode} ${response.statusMessage}');
        return ComplaintResponse(
            status: false, message: 'Failed to submit complaint');
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.response?.data}');
        print('Request: ${e.requestOptions.data}');
        print('Headers: ${e.requestOptions.headers}');
      }
      print('Gagal mengirim aduan: $e');
      return ComplaintResponse(
          status: false, message: 'Failed to submit complaint: $e');
    }
  }
}
