import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(),
      body: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 159,
                  height: 41,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: ColorCollections.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text(
                    'Tentang Aplikasi',
                    style: HomeTextCollections.textButtonAboutApp,
                  )),
                ),
                const SizedBox(
                  height: 9,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'KeluhProv adalah aplikasi untuk melaporkan keluhan masyarakat di Provinsi Banten. Dengan antarmuka yang mudah digunakan, penduduk bisa dengan cepat mengirimkan keluhan mereka tentang infrastruktur, layanan publik, atau masalah lingkungan. Aplikasi ini memudahkan pelacakan status keluhan dan membantu pemerintah memperbaiki layanan publik.',
                    textAlign: TextAlign.justify,
                    style: HomeTextCollections.description,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 165,
                  height: 41,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: ColorCollections.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text(
                    'Slogan KeluhProv',
                    style: HomeTextCollections.textButtonAboutApp,
                  )),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Image(
                    image: AssetImage('assets/images/slogan_bersuara.png')),
                Text(
                  'Memberikan platform bagi masyarakat\nuntuk menyampaikan aduan atau\nmasalah yang mereka hadapi dengan\nmudah dan cepat.',
                  textAlign: TextAlign.center,
                  style: HomeTextCollections.description,
                ),
                const SizedBox(
                  height: 11,
                ),
                const Image(
                    image: AssetImage('assets/images/slogan_beraksi.png')),
                Text(
                  'Setiap aduan yang dilaporkan tidak hanya\ndidengar, tetapi juga segera\nditindaklanjuti. Tim aplikasi akan segera\nmengambil langkah untuk\nmenyelesaikan masalah yang dilaporkan\noleh masyarakat.',
                  textAlign: TextAlign.center,
                  style: HomeTextCollections.description,
                ),
                const SizedBox(
                  height: 11,
                ),
                const Image(
                    image: AssetImage('assets/images/slogan_berhasil.png')),
                Text(
                  'Akhirnya, hasil dari tindakan tersebut\nadalah penyelesaian yang berhasil dari\nmasalah yang dilaporkan.',
                  textAlign: TextAlign.center,
                  style: HomeTextCollections.description,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
