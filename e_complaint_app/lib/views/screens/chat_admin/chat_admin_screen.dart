import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/components/triangle.dart';
import 'package:flutter/material.dart';
import 'package:e_complaint_app/controllers/chatAdmin_controller.dart';

class ChatAdmin extends StatefulWidget {
  const ChatAdmin({Key? key}) : super(key: key);

  @override
  State<ChatAdmin> createState() => _ChatAdminState();
}

class _ChatAdminState extends State<ChatAdmin> {
  final ChatAdminController _chatAdminController = ChatAdminController();

  @override
  void initState() {
    super.initState();
    _chatAdminController.loadMessages((messages) {
      setState(() {
        _chatAdminController.messages.addAll(messages);
      });
    });
  }

  void _showMessageBubble() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to send a request. Please try again.'),
      ),
    );
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
                  backgroundImage: AssetImage('assets/images/adminn.jpg'),
                  radius: 21,
                ),
                Positioned(
                  bottom: 0,
                  right: 3,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      
                    ),
                  ),
                ),
              ],
            ),
          if (!isUser) SizedBox(width: 10),
          Flexible(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: isUser ? ColorCollections.primaryColor : Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
                Positioned(
                  left: isUser ? null : 0,
                  right: isUser ? 0 : null,
                  top: 10,
                  child: CustomPaint(
                    painter: TrianglePainter(
                      isUser: isUser,
                      color: isUser ? ColorCollections.primaryColor : Colors.white70,
                    ),
                    child: Container(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateLabel(String text) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        child: Text(
          text,
          style: TextCollections.messageToday,
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
                backgroundImage: AssetImage('assets/images/adminn.jpg'),
                radius: 21,
              ),
              Positioned(
                  bottom: 0,
                  right: 3,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      
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
                'Admin',
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
      backgroundColor: ColorCollections.chatColor,
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 20, left: 4, right: 16, bottom: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: _buildBotProfile(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _chatAdminController.messages.length + 1,
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
                final message = _chatAdminController.messages[index - 1];
                return _buildMessageBubble(
                  message['content']!,
                  message['timestamp']!,
                  message['role'] == 'user',
                );
              },
            ),
          ),
          if (_chatAdminController.isLoading) const CircularProgressIndicator(),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: _chatAdminController.complaintController,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              hintStyle: TextCollections.messageType,
                              border: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 16),
                            maxLines: null, 
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 35.94,
                    color: Colors.grey,
                  ),
                  IconButton(
                    icon: Icon(Icons.send_outlined),
                    onPressed: () {
                      setState(() {
                        _chatAdminController.sendMessage(setState, _showMessageBubble);
                      });
                    },
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
