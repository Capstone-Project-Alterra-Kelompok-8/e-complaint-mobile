import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CommentService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/complaints/';

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<dynamic>> fetchComments(String complaintId) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final String url = '$_baseUrl$complaintId/discussions';
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      print('Error in fetchComments: $e');
      return [];
    }
  }

  Future<void> postComment(String complaintId, String comment) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final String url = '$_baseUrl$complaintId/discussions';
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode({'comment': comment}),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to post comment');
      }
    } catch (e) {
      print('Error in postComment: $e');
    }
  }

  Future<void> deleteComment(String complaintId, int commentId) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final String url = '$_baseUrl$complaintId/discussions/$commentId';
      final response = await _dio.delete(
        url,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete comment');
      }
    } catch (e) {
      print('Error in deleteComment: $e');
    }
  }

  Future<void> updateComment(String complaintId, int commentId, String newComment) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final String url = '$_baseUrl$complaintId/discussions/$commentId';
      final response = await _dio.put(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode({'comment': newComment}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update comment');
      }
    } catch (e) {
      print('Error in updateComment: $e');
    }
  }
}
