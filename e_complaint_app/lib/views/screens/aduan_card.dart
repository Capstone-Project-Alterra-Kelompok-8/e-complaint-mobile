import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'comment.dart';

class AduanCard extends StatefulWidget {
  const AduanCard({Key? key}) : super(key: key);

  @override
  _AduanCardState createState() => _AduanCardState();
}

class _AduanCardState extends State<AduanCard> {
  int likeCount = 10;
  bool _isLiked = false;
  bool _isExpanded = false;
  PageController _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  String completionStatus = 'Selesai';

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
    String name = 'John Doe';
    String initials = _getInitials(name);
    String description =
        'Dengan segala hormat, kami warga daerah Tangerang ingin mengajukan aduan terkait kondisi banjir yang semakin Dengan segala hormat, kami warga daerah Tangerang ingin mengajukan aduan terkait kondisi banjir yang semakin Dengan segala hormat, kami warga daerah Tangerang ingin mengajukan aduan terkait kondisi banjir yang semakin';

    List<String> imageUrls = [
      'assets/contoh.jpeg',
      'assets/contoh.jpeg',
      'assets/contoh.jpeg',
    ];

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
                    backgroundColor: Colors.blueGrey,
                    child: Text(
                      initials,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    name,
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
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            imageUrls[index],
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
                            itemCount: imageUrls.length,
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
                    'Infrastruktur',
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
                'Tangerang',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                'ID : #12345678',
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
                      ? description
                      : '${description.substring(0, 100)}...',
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
                    completionStatus,
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

  String _getInitials(String name) {
    List<String> nameSplit = name.split(' ');
    String initials = '';
    if (nameSplit.length >= 2) {
      initials = nameSplit[0][0] + nameSplit[1][0];
    } else if (nameSplit.isNotEmpty) {
      initials = nameSplit[0][0];
    }
    return initials.toUpperCase();
  }
}
