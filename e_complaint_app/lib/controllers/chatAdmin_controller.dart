import 'dart:convert';
import 'package:e_complaint_app/services/chat_ai_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ChatAdminController {
  final TextEditingController complaintController = TextEditingController();
  final List<Map<String, String>> messages = [];
  bool isLoading = false;

  void loadMessages(Function(List<Map<String, String>>) updateMessages) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? messagesString = prefs.getString('chatMessages');
    if (messagesString != null) {
      List<dynamic> messagesJson = jsonDecode(messagesString);
      updateMessages(messagesJson.map((message) => Map<String, String>.from(message)).toList());
    }
  }

  void saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String messagesString = jsonEncode(messages);
    await prefs.setString('chatMessages', messagesString);
  }

  void sendMessage(Function setState, Function showMessageBubble) async {
    if (complaintController.text.trim().isEmpty) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return;
    }

    setState(() {
      messages.add({
        'role': 'user',
        'content': complaintController.text,
        'timestamp': DateFormat('HH:mm').format(DateTime.now())
      });
      isLoading = true;
    });
    saveMessages(); 

    try {
      final result = await ChatbotService.sendMessage(
        message: complaintController.text,
      );

      setState(() {
        messages.add({
          'role': 'bot',
          'content': result.botResponse,
          'timestamp': DateFormat('HH:mm').format(DateTime.now())
        });
        isLoading = false;
      });
      saveMessages(); 
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      showMessageBubble();
    } finally {
      complaintController.clear();
    }
  }
}
