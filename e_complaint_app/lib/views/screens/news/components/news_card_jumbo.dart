import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/news_controller.dart';
import 'package:e_complaint_app/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_complaint_app/views/screens/news/components/news_comment.dart';
import 'package:e_complaint_app/views/screens/news/components/news_detail.dart';
import 'package:provider/provider.dart';

class NewsCardJumbo extends StatefulWidget {
  final NewsModel news;

  const NewsCardJumbo({Key? key, required this.news}) : super(key: key);

  @override
  State<NewsCardJumbo> createState() => _NewsCardJumboState();
}

class _NewsCardJumboState extends State<NewsCardJumbo> {
  bool isFavorite = false; // Track favorite state
  @override
  Widget build(BuildContext context) {
    final newsController = Provider.of<NewsController>(context);
    if (!newsController.isLoaded) {
      newsController.getNews();
    }
    
    final newsItem = widget.news;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetail(news: newsItem),
          ),
        );
      },
      child: Container(
        height: 380,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 16,
              offset: Offset(0, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 22.5, left: 16, right: 16, bottom: 22.5),
          child: Column(
            children: [
              Container(
                height: 178,
                width: double.infinity,
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(newsItem.files.isNotEmpty
                        ? newsItem.files[0].url
                        : 'https://via.placeholder.com/150x150.png?text=No+Image'),
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
              Gap(10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        newsItem.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C1C1C),
                        ),
                      ),
                    ),
                    Gap(20),
                    Row(
                      children: [
                        Text(
                          newsItem.admin?.name ?? 'Admin',
                          style: TextCollections.primaryFont.copyWith(
                            fontSize: 12,
                            color: Color(0xFF1C1C1C),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        Text(
                          newsItem.updatedAt,
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
      ),
    );
  }
}
