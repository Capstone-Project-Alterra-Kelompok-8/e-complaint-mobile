import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsBottomSheet extends StatefulWidget {
  final int newsId;

  const CommentsBottomSheet({Key? key, required this.newsId}) : super(key: key);

  @override
  _CommentsBottomSheetState createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch comments when the bottom sheet is opened
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<NewsCommentController>(context, listen: false).getNewsComment(widget.newsId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsCommentController = Provider.of<NewsCommentController>(context);

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
            child: _buildCommentsList(newsCommentController),
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
                        'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10), // Space between avatar and text field
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Tambahkan komentar...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    final comment = _controller.text;
                    if (comment.isNotEmpty) {
                      await newsCommentController.postNewsComment(widget.newsId.toString(), comment);
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

  Widget _buildCommentsList(NewsCommentController newsCommentController) {
    if (!newsCommentController.isLoaded) {
      return Center(child: CircularProgressIndicator());
    } else if (newsCommentController.errorMessage.isNotEmpty) {
      return Center(child: Text(newsCommentController.errorMessage));
    } else if (newsCommentController.newsComments.isEmpty) {
      return Center(child: Text('Tidak ada komentar tersedia'));
    } else {
      return ListView.builder(
        itemCount: newsCommentController.newsComments.length,
        itemBuilder: (BuildContext context, int index) {
          final comment = newsCommentController.newsComments[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                comment.user?.profilePhoto ?? comment.admin?.profilePhoto ?? 'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
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
