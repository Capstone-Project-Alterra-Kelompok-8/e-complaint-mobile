import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AduankuService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/complaints';

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, dynamic>> getComplaintLikes(String id) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await _dio.get(
        '$_baseUrl/$id/likes',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch initial data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getComplaintLikes: $e');
      return {};
    }
  }

  Future<void> toggleComplaintLike(String id, bool isLiked) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await _dio.post(
        '$_baseUrl/$id/likes',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: jsonEncode({'liked': isLiked}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to toggle like: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in toggleComplaintLike: $e');
    }
  }
}
