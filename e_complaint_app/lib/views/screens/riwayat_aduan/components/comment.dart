import 'package:e_complaint_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:e_complaint_app/services/comment_service.dart'; 

class CommentScreen extends StatefulWidget {
  final String complaintId;

  CommentScreen({required this.complaintId});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final CommentService _commentService = CommentService();
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
    try {
      List<dynamic> comments = await _commentService.fetchComments(widget.complaintId);
      setState(() {
        _comments = comments;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load comments: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> postComment(String comment) async {
    try {
      await _commentService.postComment(widget.complaintId, comment);
      fetchComments();
      _commentController.clear();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to post comment: $e';
      });
    }
  }

  Future<void> deleteComment(int commentId) async {
    try {
      await _commentService.deleteComment(widget.complaintId, commentId);
      setState(() {
        _comments.removeWhere((comment) => comment['id'] == commentId);
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to delete comment: $e';
      });
    }
  }

  Future<void> updateComment(int commentId, String newComment) async {
    try {
      await _commentService.updateComment(widget.complaintId, commentId, newComment);
      setState(() {
        int commentIndex = _comments.indexWhere((comment) => comment['id'] == commentId);
        if (commentIndex != -1) {
          _comments[commentIndex]['comment'] = newComment;
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to update comment: $e';
      });
    }
  }

void _showEditDeleteDialog(BuildContext context, int commentId, String currentComment) {
  TextEditingController editController = TextEditingController(text: currentComment);
  bool _isEditing = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 70,
              constraints: BoxConstraints(minHeight: 30),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_isEditing)
                    TextField(
                      controller: editController,
                      decoration: InputDecoration(
                        hintText: 'Ubah Komentar anda',
                        hintStyle: TextCollections.commentAdd,
                        border: OutlineInputBorder(),
                      ),
                      minLines: 1,
                      maxLines: 3,
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_isEditing)
                        TextButton(
                          onPressed: () {
                            updateComment(commentId, editController.text);
                            Navigator.of(context).pop();
                          },
                          child: Text('Simpan', style: TextCollections.commentEditnDelete),
                        ),
                      if (_isEditing)
                        TextButton(
                          onPressed: () {
                            deleteComment(commentId);
                            Navigator.of(context).pop();
                          },
                          child: Text('Hapus', style: TextCollections.commentEditnDelete),
                        ),
                      if (!_isEditing)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isEditing = true;
                            });
                          },
                          child: Text('Edit', style: TextCollections.commentEditnDelete),
                        ),
                      if (!_isEditing)
                        Divider(height: 2, color: Colors.black),
                      if (!_isEditing)
                        TextButton(
                          onPressed: () {
                            deleteComment(commentId);
                            Navigator.of(context).pop();
                          },
                          child: Text('Hapus', style: TextCollections.commentEditnDelete),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Text(
                'Komentar',
                style: TextCollections.commentTitle,
              ),
            ],
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
                          return GestureDetector(
                            onLongPress: () {
                              _showEditDeleteDialog(context, comment['id'], comment['comment']);
                            },
                            child: _buildComment(
                              comment['user']['name'],
                              comment['comment'],
                              'user',
                            ),
                          );
                        } else if (comment.containsKey('admin')) {
                          return GestureDetector(
                            onLongPress: () {
                              _showEditDeleteDialog(context, comment['id'], comment['comment']);
                            },
                            child: _buildComment(
                              comment['admin']['name'],
                              comment['comment'],
                              'admin',
                            ),
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
              style: TextCollections.commentUser,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextCollections.commentUser,
                ),
                SizedBox(height: 4),
                Text(
                  commentText,
                  style: TextCollections.comment,
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
                hintText: 'Tambahkan Komentar',
                hintStyle: TextCollections.commentAdd,
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send_outlined, color: Colors.black),
            onPressed: () {
              String newComment = _commentController.text;
              if (newComment.isNotEmpty) {
                postComment(newComment);
              }
            },
          ),
        ],
      ),
    );
  }
}
