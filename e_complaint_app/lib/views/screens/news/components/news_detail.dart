import 'package:e_complaint_app/views/components/app_bar.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget{
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: CurvedAppBar(),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            height: 500,
          
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  height: 178,
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage('assets/images/cek.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(child: Container(
                  child: Text('Pemprov Banten mendapatkan Pendanaan Proyek Infrastruktur Air Banten'),
                ))
              ],
            ),
              
            
          ),
          
        ),
      ),
    );
  }
}