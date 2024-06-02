import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<String> _comments = [
    'This is the first comment.',
    'This is the second comment.',
    'This is the third comment.'
  ];

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Komentar',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(height: 1),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            itemCount: _comments.length,
            itemBuilder: (context, index) {
              return _buildComment('User${index + 1}', _comments[index]);
            },
          ),
        ),
        Divider(height: 1),
        _buildCommentInputField(),
      ],
    );
  }

  Widget _buildComment(String username, String commentText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey,
            child: Text(
              username[0],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                      ),
                      TextSpan(
                        text: commentText,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '2h',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Reply',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInputField() {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blueGrey,
            child: Text(
              'JD', // Placeholder initials or user image can be added here
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              String newComment = _commentController.text;
              if (newComment.isNotEmpty) {
                setState(() {
                  _comments.add(newComment);
                  _commentController.clear();
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
