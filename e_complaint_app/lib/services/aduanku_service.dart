import 'package:http/http.dart' as http;
import 'dart:convert';

class AduankuService {
  final String baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/complaints';
  final String apiKey =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM';

  Future<Map<String, dynamic>> getComplaintLikes(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id/likes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch initial data: ${response.statusCode}');
    }
  }

  Future<void> toggleComplaintLike(String id, bool isLiked) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$id/likes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': apiKey,
      },
      body: jsonEncode(<String, bool>{
        'liked': isLiked,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle like: ${response.statusCode}');
    }
  }
}
