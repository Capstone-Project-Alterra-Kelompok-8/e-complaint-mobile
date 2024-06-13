import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentService {
  static const String baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/complaints/';

  static Future<List<dynamic>> fetchComments(String complaintId) async {
    final String url = '$baseUrl$complaintId/discussions';
    print('Fetching comments from: $url');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load comments');
    }
  }

  static Future<void> postComment(String complaintId, String comment) async {
    final String url = '$baseUrl$complaintId/discussions';
    print('Posting comment to: $url');

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM',
      },
      body: json.encode({'comment': comment}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 201) {
      throw Exception('Failed to post comment');
    }
  }

  static Future<void> deleteComment(String complaintId, int commentId) async {
    final String url = '$baseUrl$complaintId/discussions/$commentId';
    print('Deleting comment from: $url');

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete comment');
    }
  }

  static Future<void> updateComment(String complaintId, int commentId, String newComment) async {
    final String url = '$baseUrl$complaintId/discussions/$commentId';
    print('Updating comment at: $url');

    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM',
      },
      body: json.encode({'comment': newComment}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update comment');
    }
  }
}
