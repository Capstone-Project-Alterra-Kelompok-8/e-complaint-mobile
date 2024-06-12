import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentScreen extends StatefulWidget {
  final String complaintId;

  CommentScreen({required this.complaintId});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<dynamic> _comments = [];
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    final String url = 'https://capstone-dev.mdrizki.my.id/api/v1/complaints/${widget.complaintId}/discussions';
    print('Fetching comments from: $url'); 

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); 

    if (response.statusCode == 200) {
      try {
        var responseData = json.decode(response.body);
        setState(() {
          _comments = responseData['data'];
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to parse comments: $e';
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Belum ada diskusi...';
        _isLoading = false;
      });
    }
  }

  Future<void> postComment(String comment) async {
    final String url = 'https://capstone-dev.mdrizki.my.id/api/v1/complaints/${widget.complaintId}/discussions';
    print('Posting comment to: $url'); 

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM',
      },
      body: json.encode({'comment': comment}),
    );

    print('Response status: ${response.statusCode}'); 
    print('Response body: ${response.body}'); 

    if (response.statusCode == 201) {
      try {
        var responseData = json.decode(response.body);
        setState(() {
          _comments.add(responseData['data']);
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to parse new comment: $e';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Failed to post comment: ${response.statusCode}';
      });
    }
  }

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
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _errorMessage.isNotEmpty
                  ? Center(child: Text(_errorMessage))
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      itemCount: _comments.length,
                      itemBuilder: (context, index) {
                        final comment = _comments[index];
                        if (comment.containsKey('user')) {
                          return _buildComment(
                            comment['user']['name'],
                            comment['comment'],
                            'user',
                          );
                        } else if (comment.containsKey('admin')) {
                          return _buildComment(
                            comment['admin']['name'],
                            comment['comment'],
                            'admin',
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
        ),
        Divider(height: 1),
        _buildCommentInputField(),
      ],
    );
  }

  Widget _buildComment(String username, String commentText, String userType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: userType == 'admin' ? Colors.red : Colors.grey,
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
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  commentText,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                if (userType == 'admin')
                  Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
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
                postComment(newComment);
                _commentController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
