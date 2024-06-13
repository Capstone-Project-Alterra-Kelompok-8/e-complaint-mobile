import 'package:e_complaint_app/models/news_model.dart';
import 'package:dio/dio.dart';

class NewsService{
  final Dio _dio = Dio();
  final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/';
  final String _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM';

   Future getNews () async {
    var baseUrl = '${_baseUrl}news';   
    final response = await _dio.get(
      baseUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
          
        },

      ),
      
    );
    return response;

  }
  
}

// // import 'package:dio/dio.dart';
// // import 'package:e_complaint_app/models/news_model.dart';

// // class NewsService {
// //   final Dio _dio = Dio();
// //   final String _baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/';
// //   final String _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM';

// //   Future<List<NewsModel>> getNews() async {
// //     try {
// //       final response = await _dio.get(
// //         '${_baseUrl}news',
// //         options: Options(
// //           headers: {
// //             'Authorization': 'Bearer $_token',
// //           },
// //         ),
// //       );

// //       if (response.statusCode == 200) {
// //         List<NewsModel> news = (response.data as List)
// //             .map((item) => NewsModel.fromJson(item))
// //             .toList();
// //         return news;
// //       } else {
// //         throw Exception('Failed to load news: ${response.statusCode} ${response.statusMessage}');
// //       }
// //     } on DioError catch (e) {
// //       throw Exception('Failed to load news: ${e.response?.data ?? e.message}');
// //     }
// //   }
// // }



// import 'dart:convert';
// import 'package:e_complaint_app/models/news_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class NewsService {
//   final String _baseUrl = 'https://capstone-dev.mdrizki.my.id';
//   final String _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM';

//   Future<List<NewsModel>> getNews() async {
//     final url = Uri.parse('$_baseUrl/api/v1/news');
    
//     debugPrint('Requesting: $url');

//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer $_token',
//         },
//       );
      
//       debugPrint('Response status: ${response.statusCode}');
//       debugPrint('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         debugPrint('Success get: ${response.body}');
//         final Map<String, dynamic> responseBody = jsonDecode(response.body);
//         if (responseBody['status']) {
//           debugPrint('Response status is true');
//           List<dynamic> data = responseBody['data'];
//           return data.map((json) => NewsModel.fromJson(json)).toList();
//         } else {
//           debugPrint('Response status is false: ${responseBody['message']}');
//           throw Exception('Failed to load reports: ${responseBody['message']}');
//         }
//       } else {
//         debugPrint('Failed to load reports: ${response.statusCode}');
//         throw Exception('Failed to load reports: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error: $e');
//       throw Exception('Error: $e');
//     }
//   }
// }