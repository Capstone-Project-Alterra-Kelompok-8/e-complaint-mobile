import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/components/triangle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_complaint_app/controllers/chatBot_controller.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatBotController(),
      child: Scaffold(
        backgroundColor: ColorCollections.chatColor,
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 30, left: 4, right: 16, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildBotProfile(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<ChatBotController>(
                builder: (context, controller, child) {
                  return ListView.builder(
                    itemCount: controller.messages.length + 1,
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
                      final message = controller.messages[index - 1];
                      return _buildMessageBubble(
                        message['content']!,
                        message['timestamp']!,
                        message['role'] == 'user',
                      );
                    },
                  );
                },
              ),
            ),
            Consumer<ChatBotController>(
              builder: (context, controller, child) {
                return controller.isLoading
                    ? const CircularProgressIndicator()
                    : Container(
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
                                        controller: controller.complaintController,
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
                                icon: Icon(Icons.send_outlined, color: ColorCollections.primaryColor,),
                                onPressed: () {
                                  controller.sendMessage(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
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
                  backgroundImage: AssetImage('assets/images/bot.jpg'),
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
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(
          text,
          style: TextCollections.messageToday,
        ),
      ),
    );
  }

  Widget _buildBotProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/bot.jpg'),
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
                'Bot',
                style: TextCollections.messageProfileBot,
              ),
              Text(
                'Aktif sekarang',
                style: TextCollections.messageActiveNow,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
