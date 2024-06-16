import 'package:e_complaint_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({super.key});

  @override
  Widget build (BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorCollections.secondaryColor,
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
            'Pemberitahuan',
            style: TextCollections.headingOne.copyWith(
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            'Pengajuanmu telah diterima, silahkan tunggu konfirmasi selanjutnya Pengajuanmu telah diterima, silahkan tunggu konfirmasi selanjutnya Pengajuanmu telah diterima, silahkan tunggu konfirmasi selanjutnya',
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextCollections.headingThree.copyWith(
              fontSize: 12,
              
             ),
          ),
          trailing: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/images/cek.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ),
    );
  }
}