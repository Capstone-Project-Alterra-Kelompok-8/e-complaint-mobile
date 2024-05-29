import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/news/components/news_card.dart';
import 'package:e_complaint_app/views/screens/news/components/news_card_jumbo.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: CurvedAppBar(
        
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.only(left: 22, right: 22, top: 20),
          child: Column(
            children: [
                TextField(
                
                decoration: InputDecoration(
                  focusColor: Colors.grey,
                  filled: true,
                  fillColor: Color(0xFFECE6F0),
                  hintText: 'Hinted search text',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Gap(10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Berita Terbaru',
                  style: TextCollections.headingTwo.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.poppins().fontFamily
                  ),
                ),
              ),
              Gap(10),
              NewsCardJumbo(),
              Gap(60),
              GridView.builder(
          controller: ScrollController(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 12 / 19,
          ),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            
            return NewsCard();
          },
        ),
             
            


            ],
          ),
        ),
      ),
    );
  }
}