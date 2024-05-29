import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorCollections.backgroundColor,
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
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 316,
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

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24 , vertical: 8),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Pemprov Banten mendapatkan Pendanaan Proyek Infrastruktur Air',
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                        ),
                      ),
                      Gap(10),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                           "KeluhProv.com - World Water Forum ke-10 menghasilkan aksi rencana konkret dengan penandatanganan kesepakatan pendanaan Sistem Penyediaan Air Minum (SPAM) Regional Karian-Serpong dan nota kesepahaman mengenai Net-Zero Water Supply Infrastructure Project di Ibu Kota Nusantara (IKN). Nota kesepahaman itu ditandatangani usai High Level Panel (HLP1) World Water Forum ke-10 di Nusantara 2 Room, Bali International Convention Center (BNDCC), Bali, Selasa (21/5/2024).Sebagai informasi, SPAM Regional Karian-Serpong merupakan Proyek Strategis Nasional berkapasitas 4.600 liter/detik. SPAM ini diharapkan dapat memberikan akses air minum kepada 1,84 juta penduduk yang tinggal di Provinsi DKI Jakarta dan Provinsi Banten, khususnya di Kota Tangerang dan Kota Tangerang Selatan. Proyek SPAM Regional Karian-Serpong memiliki nilai investasi sebesar Rp2,4 triliun. Hasil nyata lain dari World Water Forum ke-10 adalah nota kesepahaman mengenai proyek Net-Zero Water Supply Infrastructure Project di IKN Nusantara. MoU itu ditandatangani oleh Direktur Jenderal Cipta Karya Kementerian PUPR Diana Kusumastuti dan Wakil Presiden K-Water Han Seong Yong. K-Water merupakan perusahaan milik negara Korea Selatan.",
                          textAlign: TextAlign.justify,
                          style: TextCollections.primaryFont.copyWith(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                            
                            
                           
                            
                          ),
                        ),
                      ),
                        Gap(10),
                        Row(
                          children: [
                             Text(
                              'Admin',
                                style: TextCollections.primaryFont.copyWith(
                                fontSize: 12,
                                color: Color(0xFF1C1C1C),
                                fontWeight: FontWeight.w400,
                              )
                            ),
                        Spacer(),
                        Text(
                          '12 Oktober 2021',
                          style: TextCollections.primaryFont.copyWith(
                            fontSize: 12,
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
          ],
        ),
      ),
    );
  }
}
