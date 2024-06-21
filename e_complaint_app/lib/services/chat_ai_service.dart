import 'dart:convert';
import 'package:e_complaint_app/models/chat_ai_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatbotService {
  static const String baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/chatbot';

  static Future<ChatbotMessage> sendMessage({
    required String message,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final url = Uri.parse('$baseUrl/messages');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'message': message,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ChatbotMessage.fromJson(jsonResponse);
    } else {
      debugPrint('Failed to send request: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      throw Exception('Failed to send request with status code ${response.statusCode}');
    }
  }
}
