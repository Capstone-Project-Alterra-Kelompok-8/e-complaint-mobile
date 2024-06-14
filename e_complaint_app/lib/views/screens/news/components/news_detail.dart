import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/models/news_model.dart';
import 'package:e_complaint_app/views/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/news/components/news_comment.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetail extends StatefulWidget {
  final NewsModel news;

  const NewsDetail({Key? key, required this.news}) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  bool isFavorite = false; // Track favorite state
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorCollections.backgroundColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 316,
                    width: double.infinity,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.news.files.isNotEmpty
                              ? widget.news.files[0].url
                              : 'https://your_base_url/default-image-path.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => CommentsBottomSheet(
                            newsId: widget.news.id
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.comment_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite; // Toggle favorite state
                        });
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            widget.news.title,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        Gap(10),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            widget.news.content,
                            textAlign: TextAlign.justify,
                            style: TextCollections.primaryFont.copyWith(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Gap(10),
                        Row(
                          children: [
                            Text(
                              widget.news.admin.name,
                              style: TextCollections.primaryFont.copyWith(
                                fontSize: 12,
                                color: Color(0xFF1C1C1C),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Text(
                              widget.news.updatedAt,
                              style: TextCollections.primaryFont.copyWith(
                                fontSize: 12,
                                color: Color(0xFF1C1C1C),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
