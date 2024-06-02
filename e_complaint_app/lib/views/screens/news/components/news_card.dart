import 'package:e_complaint_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCard extends StatelessWidget{
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context){
    return Card(
      child: Container(
        height: 256,
        width: 162,
        decoration: BoxDecoration(
          boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 8),
            spreadRadius: 0,
           ),
          ],
          color: ColorCollections.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
       child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/news_detail'),
        child: Column(
          children: [
            Container(
              height: 128,
              width: 148,
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage('assets/images/cek.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                    spreadRadius: 0,
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
                      'Pemprov Banten mendapatkan Pendanaan Proyek Infrastruktur Air Banten',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C1C1C),
                       ),
                    ),
                  ),
                  Gap(5),
                   Row(
                          children: [
                             Text(
                              'Admin',
                                style: TextCollections.primaryFont.copyWith(
                                fontSize: 10,
                                color: Color(0xFF1C1C1C),
                                fontWeight: FontWeight.w400,
                              )
                            ),
                        Spacer(),
                        Text(
                          '12 Oktober 2021',
                          style: TextCollections.primaryFont.copyWith(
                            fontSize: 10,
                            color: Color(0xFF1C1C1C),
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


