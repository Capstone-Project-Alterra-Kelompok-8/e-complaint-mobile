import 'package:e_complaint_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCardJumbo extends StatefulWidget{
  const NewsCardJumbo({super.key});

  @override
  State<NewsCardJumbo> createState() => _NewsCardJumboState();
}

class _NewsCardJumboState extends State<NewsCardJumbo> {
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/news_detail');
      },
      child: Container(
      height: 380,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 255, 255, 255),
         boxShadow: const [
           BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 8),
            spreadRadius: 0,
          ),
         
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 22.5 , left: 16, right: 16, bottom: 22.5),
        child: Column(
          children: [
            Container(
              height: 178,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/cek.jpg'),
                  fit: BoxFit.cover,
                 
                ),
              ),
            ),
            const Gap(10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              child: Column(
                children: [
                  Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pemprov Banten mendapatkan Pendanaan Proyek Infrastruktur Air ',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextCollections.headingTwo.copyWith(
                  ),
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  Text(
                    'Admin',
                    style: TextCollections.primaryFont.copyWith(
                      fontSize: 12,
                      color: const Color(0xFF1C1C1C),
                      fontWeight: FontWeight.w400,
                    )
                   
                  ),
                  const Spacer(),
                  Text(
                    '12 Oktober 2021',
                    style: TextCollections.primaryFont.copyWith(
                      fontSize: 12,
                      color: const Color(0xFF1C1C1C),
                    )
                   
                  ),
                ],
              )
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