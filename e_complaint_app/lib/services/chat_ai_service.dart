import 'dart:convert';
import 'package:e_complaint_app/models/chat_ai.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatbotService {
  static const String baseUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/chatbot';

  static Future<ChatbotMessage> sendMessage({
    required String message,
    required String token,
  }) async {
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
      throw Exception('Failed to send request');
    }
  }
}
