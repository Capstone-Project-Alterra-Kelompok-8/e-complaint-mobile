import 'package:e_complaint_app/components/app_bar.dart';
import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/services/chat_ai_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _complaintController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
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

    setState(() {
      _messages.add(firstDefaultMessage);
      _messages.add(secondDefaultMessage);
    });
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
      final result = await ChatbotService.sendMessage(
        message: _complaintController.text,
        token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM', 
      );

      setState(() {
        _messages.add({
          'role': 'bot',
          'content': result.botResponse,
          'timestamp': DateFormat('HH:mm').format(DateTime.now())
        });
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send a request. Please try again.'),
        ),
      );
    } finally {
      _complaintController.clear();
    }
  }

  Widget _buildMessageBubble(String message, String timestamp, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/bot.jpg'),
                  radius: 31,
                  
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (!isUser) SizedBox(width: 10),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                    style: TextCollections.messageBubble,
                    textAlign: isUser ? TextAlign.right : TextAlign.left,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    timestamp,
                    style: TextCollections.timeStamp,
                    textAlign: isUser ? TextAlign.right : TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateLabel(String text) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(
          text,
          style:TextCollections.messageToday,
        ),
      ),
    );
  }

  Widget _buildBotProfile() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/bot.jpg'),
                radius: 31,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bot',
                style: TextCollections.messageProfileBot
              ),
              Text(
                'Aktif sekarang',
                style: TextCollections.messageActiveNow
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(),
      body: Column(
        children: [
          _buildBotProfile(),
          Divider(color: Colors.black, thickness: 0.2,),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      _buildDateLabel("Hari ini"),
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
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () {
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: _complaintController,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              hintStyle: TextCollections.messageType,
                              border: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 16),
                            maxLines: null, // Mengizinkan multiple lines
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.grey,
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
