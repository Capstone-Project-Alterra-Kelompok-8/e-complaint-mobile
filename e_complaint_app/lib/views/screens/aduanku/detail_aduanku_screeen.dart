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
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: CurvedAppBar(),
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
              
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  height: 244,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage('assets/images/cek.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Gap(10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16 , vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text('Banjir semakin parah di Tangerang Saluran Air Tersumbat gara-gara ada kodok', 
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
                      Gap(5),
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