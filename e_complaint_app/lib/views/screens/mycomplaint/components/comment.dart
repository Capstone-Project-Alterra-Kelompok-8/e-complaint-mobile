import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/my_complaint_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CommentMyComplaint extends StatefulWidget {
  final String complaintId;

  const CommentMyComplaint({Key? key, required this.complaintId}) : super(key: key);

  @override
  _CommentMyComplaintState createState() => _CommentMyComplaintState();
}

class _CommentMyComplaintState extends State<CommentMyComplaint> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch comments when the bottom sheet is opened
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<MyComplaintCommentController>(context, listen: false).getMyComplaintComment(widget.complaintId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myComplaintCommentController = Provider.of<MyComplaintCommentController>(context);

     return Container(
      padding: EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: Text(
                    'Komentar',
                    style: TextCollections.headingThree,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: _buildCommentsList(myComplaintCommentController),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png'
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                  onPressed: () async {
                    final comment = _controller.text;
                    if (comment.isNotEmpty) {
                      await myComplaintCommentController.postMyComplaintComment(widget.complaintId.toString(), comment);
                      _controller.clear();
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
   Widget _buildCommentsList(MyComplaintCommentController myComplaintCommentController) {
    if (!myComplaintCommentController.isLoaded) {
      return Center(child: CircularProgressIndicator());
    } else if (myComplaintCommentController.errorMessage.isNotEmpty) {
      return Center(child: Text('No comments available'));
    } else if (myComplaintCommentController.myComplaintsComment.isEmpty) {
      return Center(child: Text('No comments available'));
    } else {
      return ListView.builder(
        itemCount: myComplaintCommentController.myComplaintsComment.length,
        itemBuilder: (BuildContext context, int index) {
          final comment = myComplaintCommentController.myComplaintsComment[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                comment.user?.profilePhoto ?? comment.admin?.url ?? 'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
              ),
            ),
            title: Text(comment.user?.name ?? comment.admin?.name ?? 'Anonymous'),
            subtitle: Text(comment.comment),
          );
        },
      );
    }
  }
}