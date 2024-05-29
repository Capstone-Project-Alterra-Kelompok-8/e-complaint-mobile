import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget{
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      width: 162,
      height: 256,
      color: Colors.red,
      decoration: BoxDecoration(
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
     
    );
  }
}


