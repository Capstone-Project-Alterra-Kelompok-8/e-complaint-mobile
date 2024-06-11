import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProgressMyComplaintScreen extends StatefulWidget{
  const ProgressMyComplaintScreen({super.key});

  @override
  State<ProgressMyComplaintScreen> createState() => _ProgressMyComplaintScreenState();
}

class _ProgressMyComplaintScreenState extends State<ProgressMyComplaintScreen> {
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: CurvedAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorCollections.secondaryColor,
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
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Aduan Anda'.toUpperCase(),
                      style: TextCollections.headingThree.copyWith(
                        color: ColorCollections.textPrimaryColor,
                        fontSize: 18,
                        
                      ),
                    ),
                  ),
                ),
                Gap(10),
                ListTile(
                  leading: Icon(
                    Icons.circle_outlined,
                    color: Colors.grey[600],
                    size: 30,
                  ),
                  title: Text(
                    'Pending',
                    style: TextCollections.primaryFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin',
                        style: TextCollections.headingTwo.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Kamis, 09 Mei 2024 - 04:27 WIB',
                        style: TextCollections.headingThree.copyWith(
                          fontSize: 14,
                          color: Color(0xEC5A5A5A),
                        ),
                      ),
                      Text(
                        'Laporan Anda akan segera kami periksa.',
                        style: TextCollections.headingThree.copyWith(
                          fontSize: 14,
                          color: Color(0xEC5A5A5A),
                        ),
                      ),
                    ],
                  )
                ),
                ListTile(
                  leading: Icon(
                    Icons.circle_outlined,
                    color: Colors.blueAccent[700],
                    size: 30,
                  ),
                  title: Text(
                    'Verifikasi',
                    style: TextCollections.primaryFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent[700],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin',
                        style: TextCollections.headingTwo.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Kamis, 09 Mei 2024 - 06.19 WIB',
                        style: TextCollections.headingThree.copyWith(
                          fontSize: 14,
                          color: Color(0xEC5A5A5A),
                        ),
                      ),
                      Text(
                        'Laporan Anda telah di periksa, terimakasih informasinya!',
                        style: TextCollections.headingThree.copyWith(
                          fontSize: 14,
                          color: Color(0xEC5A5A5A),
                        ),
                      ),
                    ],
                  )
                ),
                ListTile(
                  leading: Icon(
                    Icons.circle_outlined,
                    color: Colors.yellow[700],
                    size: 30,
                  ),
                  title: Text(
                    'On Progress',
                    style: TextCollections.primaryFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow[700],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin',
                        style: TextCollections.headingTwo.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Kamis, 09 Mei 2024 - 06.25 WIB',
                        style: TextCollections.headingThree.copyWith(
                          fontSize: 14,
                          color: Color(0xEC5A5A5A),
                        ),
                      ),
                      Text(
                        'Laporan Anda telah di kirimkan ke tim Kabupaten Banjar Negara.',
                        style: TextCollections.headingThree.copyWith(
                          fontSize: 14,
                          color: Color(0xEC5A5A5A),
                        ),
                      ),
                    ],
                  )
                ),
                ListTile(
                  leading: Icon(
                    Icons.circle_outlined,
                    color: Colors.green,
                    size: 30,
                  ),
                  title: Text(
                    'Selesai',
                    style: TextCollections.primaryFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin',
                        style: TextCollections.headingTwo.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Kamis, 14 Oktober 2021',
                        style: TextCollections.headingThree.copyWith(
                          fontSize: 14,
                          color: Color(0xEC5A5A5A),
                        ),
                      ),
                      Text(
                        'Laporan telah diterima, Kabupaten Banjar Negara akan melakukan pemantauan dan penertiban. Terimakasih!',
                        style: TextCollections.headingThree.copyWith(
                          fontSize: 14,
                          color: Color(0xEC5A5A5A),
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}