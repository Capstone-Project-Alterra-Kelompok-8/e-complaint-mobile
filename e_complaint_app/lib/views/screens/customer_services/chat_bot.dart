import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/services/recomendation_service.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
// import 'package:e_complaint_app/services/recommendation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _complaintController = TextEditingController();
  final List<Map<String, String>> _messages = []; // List to store chat messages
  bool isLoading = false;


void initState() {
    super.initState();
    _addDefaultMessages();
  }

  void _addDefaultMessages() {
    final firstDefaultMessage = {
      'role': 'bot',
      'content': 'Hai, Roy! Aku Kava (KeluhProv AI Virtual Assistant)',
      'timestamp': DateFormat('HH:mm').format(DateTime.now()),
    };

    final secondDefaultMessage = {
      'role': 'bot',
      'content': 'Bantu KAVA agar bisa memberikan solusi yang tepat & cepat supaya bisa kami bantu secepatnya',
      'timestamp': DateFormat('HH:mm').format(DateTime.now()),
    };

    _messages.add(firstDefaultMessage);
    _messages.add(secondDefaultMessage);
  }
  void _sendMessage() async {
    if (_complaintController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      _messages.add({
        'role': 'user',
        'content': _complaintController.text,
        'timestamp': DateFormat('HH:mm').format(DateTime.now())
      });
      isLoading = true;
    });

    try {
      final result = await RecommendationService.getRecommendations(
        complaint: _complaintController.value.text,
      );

      setState(() {
        if (result.choices != null && result.choices.isNotEmpty) {
          final message = result.choices[0]?.message?.content;
          if (message != null) {
            _messages.add({
              'role': 'bot',
              'content': message,
              'timestamp': DateFormat('HH:mm').format(DateTime.now())
            });
          }
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      const snackBar = SnackBar(
        content: Text('Failed to send a request. Please try again.'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      _complaintController.clear();
    }
  }

  Widget _buildMessageBubble(String message, String timestamp, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextCollections.primaryFont
            ),
            const SizedBox(height: 5),
            Text(
              timestamp,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateLabel(String text) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: TextCollections.hariIniTwo
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 10), 
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length + 1, 
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      const SizedBox(height: 10), 
                      _buildDateLabel("Hari ini",),
                      const SizedBox(height: 10), 
                    ],
                  );
                }
                final message = _messages[index - 1];
                return _buildMessageBubble(
                  message['content']!,
                  message['timestamp']!,
                  message['role'] == 'user',
                );
              },
            ),
          ),
          if (isLoading) const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0), 
                          color: Colors.grey[200], 
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                                      controller: _complaintController,
                                      decoration: InputDecoration(
                                        hintText: 'Tulis Pesan di sini (maks. 30 kata)',
                                        border: InputBorder.none,
                                        hintStyle: TextCollections.textField
                                      ),
                                      maxLength: 30, 
                                      maxLines: 1, 
                                    ),
                                  ),
                        ),
                      ),
                    ),
                ButtonCollections.stackedButton(_sendMessage),
              ]
            ),
          ),
        ],
      ),
    );
  }
}
