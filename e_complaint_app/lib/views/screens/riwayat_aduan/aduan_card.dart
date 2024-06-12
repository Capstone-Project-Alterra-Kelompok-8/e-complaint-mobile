import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:e_complaint_app/views/screens/riwayat_aduan/comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final int totalLikes;

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
    required this.totalLikes,
  }) : super(key: key);

  @override
  _AduanCardState createState() => _AduanCardState();
}

class _AduanCardState extends State<AduanCard> {
  int likeCount = 0;
  bool _isLiked = false;
  bool _isExpanded = false;
  PageController _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    likeCount = widget.totalLikes;
    _fetchInitialData();
  }

  void _toggleLike() async {
  // Mengubah status suka dan jumlah suka sebelum mengirim permintaan ke server
  bool previousLikedStatus = _isLiked;
  setState(() {
    _isLiked = !_isLiked;
    if (_isLiked) {
      likeCount++;
    } else {
      likeCount--;
    }
  });

  // Mengirim permintaan ke server untuk memperbarui status suka
  String apiUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/complaints/${widget.id}/likes';
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM',
    },
    body: jsonEncode(<String, bool>{
      'liked': _isLiked,
    }),
  );

  // Jika permintaan gagal, kembalikan status suka dan jumlah suka ke kondisi sebelumnya
  if (response.statusCode != 200) {
    setState(() {
      _isLiked = previousLikedStatus;
      if (_isLiked) {
        likeCount++;
      } else {
        likeCount--;
      }
    });
    print('Failed to toggle like: ${response.statusCode}');
  }
}


  void _fetchInitialData() async {
    String apiUrl = 'https://capstone-dev.mdrizki.my.id/api/v1/complaints/${widget.id}/likes';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlVzZXIgMiIsImVtYWlsIjoidXNlcjJAZ21haWwuY29tIiwicm9sZSI6InVzZXIifQ.DgppkPOyYZNCPpNHkW4R4j-bE1GL0SpLwMfX3vtYtyM',
      },
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      setState(() {
        likeCount = responseData['likes_count'] ?? widget.totalLikes;
        _isLiked = responseData['liked'] ?? false;
      });
    } else {
      print('Failed to fetch initial data: ${response.statusCode}');
    }
  }

  void _showCommentSheet(BuildContext context, String complaintId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: CommentScreen(complaintId: complaintId),
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
                          _showCommentSheet(context, widget.id);
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
