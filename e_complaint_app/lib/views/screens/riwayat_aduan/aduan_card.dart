import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'comment.dart';

class AduanCard extends StatefulWidget {
  final String id;
  final String name;
  final String initials;
  final String description;
  final String category;
  final String regency;
  final String status;
  final String profilePhoto;
  final List<String> files;

  const AduanCard({
    Key? key,
    required this.id,
    required this.name,
    required this.initials,
    required this.description,
    required this.category,
    required this.regency,
    required this.status,
    required this.profilePhoto,
    required this.files,
  }) : super(key: key);

  @override
  _AduanCardState createState() => _AduanCardState();
}

class _AduanCardState extends State<AduanCard> {
  int likeCount = 10;
  bool _isLiked = false;
  bool _isExpanded = false;
  PageController _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      likeCount += _isLiked ? 1 : -1;
    });
  }

  void _showCommentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: CommentScreen(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(widget.profilePhoto),
                    backgroundColor: Colors.blueGrey,
                    child: widget.profilePhoto.endsWith('default.jpg')
                        ? Text(
                            widget.initials,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          )
                        : null,
                  ),
                  SizedBox(width: 16),
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  width: 350,
                  height: 350,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: widget.files.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.files[index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                        onPageChanged: (index) {
                          _currentPageNotifier.value = index;
                        },
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CirclePageIndicator(
                            dotColor: Colors.grey,
                            selectedDotColor: Colors.blue,
                            itemCount: widget.files.length,
                            currentPageNotifier: _currentPageNotifier,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.category,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showCommentSheet(context);
                        },
                        child: Icon(Icons.comment),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: _toggleLike,
                        child: Icon(
                          Icons.favorite,
                          color: _isLiked ? Colors.red : Colors.grey,
                        ),
                      ),
                      SizedBox(width: 2),
                      Text(
                        '$likeCount',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                widget.regency,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                widget.id,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 37, 100, 235),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded
                      ? widget.description
                      : widget.description.length > 100
                          ? '${widget.description.substring(0, 100)}...'
                          : widget.description,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  overflow: TextOverflow.fade,
                ),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? 'Sembunyikan' : 'Selengkapnya',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.status,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
