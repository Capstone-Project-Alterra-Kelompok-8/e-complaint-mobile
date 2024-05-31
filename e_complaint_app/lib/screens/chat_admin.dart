import 'package:e_complaint_app/env/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:e_complaint_app/components/app_bar.dart';

class ChatAdmin extends StatelessWidget {
  const ChatAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/admin.png'),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin',
                          style: TextCollections.admin
                        ),
                        Text(
                          'Active now',
                          style: TextCollections.activeNow
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.call),
                      onPressed: () {
                        
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.videocam),
                      onPressed: () {
                        
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    'Hari ini',
                    style: TextCollections.hariIni
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: ColorCollections.bubleTextColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.zero,
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          'Hello Admin?',
                          style: TextCollections.primaryFont,
                        ),
                      ),
                      Text(
                        '${TimeOfDay.now().format(context)}',
                        style: TextCollections.timeStamp
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/admin.png'),
                      ),
                      SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            margin: const EdgeInsets.fromLTRB(4.0, 2.0, 0.0, 4.0), // Adjust the margin here
                            decoration: BoxDecoration(
                              color: ColorCollections.bubleTextColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.zero,
                                topRight: Radius.circular(32),
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              'Hai ada yang bisa dibantu?',
                              style: TextCollections.primaryFont,
                            ),
                          ),
                          Text(
                            '${TimeOfDay.now().format(context)}',
                            style: TextCollections.timeStamp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {
                    
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: InputBorder.none,
                      hintStyle: TextCollections.textField,
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
                  onPressed: () {
                    
                  },
                ),
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                      
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
