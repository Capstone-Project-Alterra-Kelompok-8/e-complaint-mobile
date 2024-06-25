import 'dart:convert';
import 'package:e_complaint_app/services/chat_ai_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ChatAdminController extends ChangeNotifier {
  final TextEditingController complaintController = TextEditingController();
  final List<Map<String, String>> messages = [];
  bool isLoading = false;

  ChatAdminController() {
    loadMessages();
  }

  void loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? messagesString = prefs.getString('chatMessages');
    if (messagesString != null) {
      List<dynamic> messagesJson = jsonDecode(messagesString);
      messages.addAll(messagesJson.map((message) => Map<String, String>.from(message)).toList());
      notifyListeners();
    }
  }

  void saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String messagesString = jsonEncode(messages);
    await prefs.setString('chatMessages', messagesString);
  }

  void sendMessage(Function showMessageBubble) async {
    if (complaintController.text.trim().isEmpty) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return;
    }

    messages.add({
      'role': 'user',
      'content': complaintController.text,
      'timestamp': DateFormat('HH:mm').format(DateTime.now())
    });
    isLoading = true;
    notifyListeners();
    saveMessages();

    try {
      final result = await ChatbotService.sendMessage(
        message: complaintController.text,
      );

      messages.add({
        'role': 'bot',
        'content': result.botResponse,
        'timestamp': DateFormat('HH:mm').format(DateTime.now())
      });
      isLoading = false;
      notifyListeners();
      saveMessages();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showMessageBubble();
    } finally {
      complaintController.clear();
    }
  }
}
