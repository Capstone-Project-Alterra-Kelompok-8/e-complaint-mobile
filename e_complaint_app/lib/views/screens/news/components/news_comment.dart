import 'package:flutter/material.dart';

class CommentsBottomSheet extends StatefulWidget {
  @override
  _CommentsBottomSheetState createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final List<String> comments = [
    "This is a great post! betul pak kemarin gak bisa itu tapi ya gimana lagi jalan sudah lwat",
    "Awesome picture!",
    "Love this!",
    "So beautiful!",
    "Amazing!",
    "Fantastic!",
    "So cool!",
    "Nice shot!",
    "Incredible!",
    "Wow!",
  ];

  final TextEditingController _controller = TextEditingController();

  void _addComment(String comment) {
    setState(() {
      comments.add(comment);
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        children: <Widget>[
          Text(
            'Comments',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(comments[index][0]),
                  ),
                  title: Text('User'),
                  subtitle: Text(comments[index]),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addComment(_controller.text);
                    }
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
