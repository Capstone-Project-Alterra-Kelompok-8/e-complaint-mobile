import 'package:e_complaint_app/services/chat_ai_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatBotController extends ChangeNotifier {
  final TextEditingController complaintController = TextEditingController();
  final List<Map<String, String>> messages = [];
  bool isLoading = false;

  ChatBotController() {
    _addDefaultMessages();
  }

  void _addDefaultMessages() {
    final firstDefaultMessage = {
      'role': 'bot',
      'content': 'Hai, Aku Kava (KeluhProv AI Virtual Assistant)',
      'timestamp': DateFormat('HH:mm').format(DateTime.now()),
    };

    final secondDefaultMessage = {
      'role': 'bot',
      'content': 'Bantu KAVA agar bisa memberikan solusi yang tepat & cepat supaya bisa kami bantu secepatnya',
      'timestamp': DateFormat('HH:mm').format(DateTime.now()),
    };

    messages.add(firstDefaultMessage);
    messages.add(secondDefaultMessage);
    notifyListeners();
  }

  Future<void> sendMessage(BuildContext context) async {
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
    } catch (e) {
      isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send a request. Please try again.'),
        ),
      );
    } finally {
      complaintController.clear();
    }
  }
}
