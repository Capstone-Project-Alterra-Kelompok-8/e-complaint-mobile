import 'dart:convert';
import 'package:e_complaint_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User?> getUserById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return null;
    }

    final response = await http.get(
      Uri.parse('https://capstone-dev.mdrizki.my.id/api/v1/users/:id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == true) {
        return User.fromJson(data['data']);
      }
    }

    return null;
  }
}
