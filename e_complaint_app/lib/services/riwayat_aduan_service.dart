import 'package:e_complaint_app/models/riwayat_aduan_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatAduanService {
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1';

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, dynamic>> getComplaintLikes(String complaintId) async {
    final token = await getToken();
    if (token == null) {
      throw Exception("Token not found");
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/complaints/$complaintId/likes'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load complaint likes');
    }
  }

  Future<void> toggleComplaintLike(String complaintId, bool isLiked) async {
    final token = await getToken();
    if (token == null) {
      throw Exception("Token not found");
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/complaints/$complaintId/likes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'liked': isLiked}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle like');
    }
  }

  Future<List<Complaint>> fetchComplaints() async {
    final token = await getToken();
    if (token == null) {
      throw Exception("Token not found");
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/complaints?sort_by=id&sort_type=desc'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] != null && jsonResponse['data'] is List) {
        return (jsonResponse['data'] as List)
            .map((data) => Complaint.fromJson(data))
            .toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load complaints: ${response.statusCode}');
    }
  }
}
