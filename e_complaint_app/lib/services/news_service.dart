import 'package:e_complaint_app/models/news_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/';

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future getNews() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await _dio.get(
        '${_baseUrl}news',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      print('Error in getNews: $e');
      return null;
    }
  }
}

class NewsCommentService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/';

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future getNewsComment(String newsId) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await _dio.get(
        '${_baseUrl}news/$newsId/comments',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      print('Error in getcomment: $e');
      return null;
    }
  }

  Future<Response?> postNewsComment(String newsId, String comment) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await _dio.post(
        '${_baseUrl}news/$newsId/comments',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'comment': comment,
        },
      );
      return response;
    } catch (e) {
      print('Error in postNewsComment: $e');
      return null;
    }
  }
}
