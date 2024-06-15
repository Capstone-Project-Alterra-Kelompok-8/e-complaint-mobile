import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/notification/components/card_notification.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:e_complaint_app/constants/constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedIndex = 0; // Variabel untuk melacak tombol aktif

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == 0 ? ColorCollections.buttonColor : ColorCollections.backgroundColor, // Ubah warna jika tombol 1 aktif
                    enabledMouseCursor: MouseCursor.defer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: ColorCollections.buttonColor), // Tambahkan border jika tombol 1 aktif
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIndex = 0; // Atur tombol 1 sebagai aktif
                    });
                  },
                  child: Text('Semua Aktivitas', 
                    style: TextCollections.headingThree.copyWith(
                      color: selectedIndex == 0 ? Colors.white : ColorCollections.buttonColor,
                      fontSize: 12,
                       // Ubah warna teks jika tombol 1 aktif
                    ),
                  ),
                ),
                SizedBox(width: 8), // Spasi antara tombol
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == 1 ? ColorCollections.buttonColor : ColorCollections.backgroundColor,
                    enabledMouseCursor: MouseCursor.defer,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorCollections.buttonColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1; // Atur tombol 2 sebagai aktif
                    });
                  },
                  child: Text('Suka' ,
                    style: TextCollections.headingThree.copyWith(
                      color: selectedIndex == 1 ? Colors.white : ColorCollections.buttonColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: 8), // Spasi antara tombol
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == 2 ? ColorCollections.buttonColor : ColorCollections.backgroundColor, // Ubah warna jika tombol 3 aktif
                    enabledMouseCursor: MouseCursor.defer,
                    shape: RoundedRectangleBorder(
                       side: BorderSide(color: ColorCollections.buttonColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIndex = 2; // Atur tombol 3 sebagai aktif
                    });
                  },
                  child: Text('Komentar' , 
                    style: TextCollections.headingThree.copyWith(
                      color: selectedIndex == 2 ? Colors.white : ColorCollections.buttonColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Gap(20),
            ListView.builder(itemBuilder: (context, index) => CardNotification(), itemCount: 8, shrinkWrap: true, physics: NeverScrollableScrollPhysics(),),
           
            
         
            
            
          ],
        ),
      ),
    );
  }
}
