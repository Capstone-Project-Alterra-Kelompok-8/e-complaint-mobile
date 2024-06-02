import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DetailAduankuScreen extends StatefulWidget {
  const DetailAduankuScreen({super.key});

  @override
  State<DetailAduankuScreen> createState() => _DetailAduankuScreenState();
}

class _DetailAduankuScreenState extends State<DetailAduankuScreen> {
  final CarouselController _controller = CarouselController();
  final List<String> images = [
    'assets/images/cek.jpg',
    'assets/images/cek.jpg',
    'assets/images/cek.jpg',
    // Tambahkan path gambar lainnya sesuai kebutuhan
  ];
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: CurvedAppBar(
     
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorCollections.secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/cek.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      'Anda',
                      style: TextCollections.headingOne.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Anonim',
                      style: TextCollections.headingThree.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                // slider
                 Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: CarouselSlider.builder(
                    carouselController: _controller,
                    itemCount: images.length,
                    options: CarouselOptions(
                      aspectRatio: 1.0,
                      height: 200,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,               
                      viewportFraction: 0.8,
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        
                        width: MediaQuery.of(context).size.width,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 6, color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              
              ],
            ),
          ],
        ),
      
                Gap(10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text('Bencana Alam', 
                          style: TextCollections.headingOne.copyWith(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold
                            ),
                            softWrap: true,
                          ),
                          ),
                          IconButton(
                            icon: Icon(Icons.comment_outlined),
                            onPressed: (){},
                          ),
                          IconButton(
                            onPressed:(){}, 
                            icon: Row(
                              children: [
                                Icon(Icons.favorite_border),
                                Text(
                                  '10Rb',
                                  style: TextCollections.headingThree.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            )
                          ),
                         
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text(
                        'Tangerang',
                        style: TextCollections.headingThree.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                      ),
                      Gap(5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text(
                        'ID :#1234567890',
                        style: TextCollections.headingThree.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue,
                        ),
                      )
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text(
                        'Dengan segala hormat, kami warga daerah Tangerang ingin mengajukan aduan terkait kondisi banjir yang semakin parah di wilayah kami. karena pemerintah tidak memeperhaitakn sehingga kodok berkeliaran di selokan  ',
                        style: TextCollections.headingThree.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      )
                      ),
                      Gap(60),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){},
                          child: Text(
                            'Selesai',
                            style: TextCollections.headingThree.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              color: Colors.blue,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/progress_aduanku');
                          },
                          child: Text(
                            'Progress Aduan',
                            style: TextCollections.headingThree.copyWith(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorCollections.buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                

              ],
            ),
          ),
        ),
      ),
      
    );
  }
}