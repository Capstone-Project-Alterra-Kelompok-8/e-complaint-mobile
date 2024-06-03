import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/screens/components/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorCollections.buttonColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(image: AssetImage('assets/images/logo_appbar.png')),
            Icon(
              Icons.notifications_none,
              size: 35,
            )
          ],
        ),
      ),
      backgroundColor: ColorCollections.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/eclipse_home.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Selamat Datang',
                            style: HomeTextCollections.welcomeText),
                        const SizedBox(height: 8.0), // Padding between texts
                        Text('Budiono Siregar',
                            style: HomeTextCollections.nameText),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: ColorCollections.textPrimaryColor,
                  ),
                ],
              ),
            ),
          ),

          // SEARCH WIDGET SECTION
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 23, left: 23, bottom: 36),
            child: TextField(
              decoration: InputDecoration(
                  fillColor: ColorCollections.secondaryColor,
                  filled: true,
                  labelText: 'Hinted Search Text',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none)),
            ),
          ),
          // FITURE HOMEPAGE SECTION
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){

                },
                child: Column(
                  children: [
                    SizedBox(
                        child: Image(
                            image: AssetImage('assets/images/icon_aduanku.png'))),
                    Text('Aduanku'),
                    Text('')
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Column(
                  children: [
                    Image(
                        image:
                            AssetImage('assets/images/icon_riwayat_aduan.png')),
                    Text('Riwayat'),
                    Text('Aduan')
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){},
                child: Column(
                  children: [
                    Image(image: AssetImage('assets/images/icon_chat_admin.png')),
                    Text('Aduanku'),
                    Text('')
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){},
                child: Column(
                  children: [
                    Image(image: AssetImage('assets/images/icon_chat_ai.png')),
                    Text('Chat AI'),
                    Text('')
                  ],
                ),
              ),
            ],
          ),

          //BERITA SECTION
          Padding(
            padding: const EdgeInsets.all(23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Berita Terbaru',
                  style: HomeTextCollections.beritaHeader,
                ),
                const Row(
                  children: [
                    Text('Lihat Semua'),
                    Icon(Icons.chevron_right_outlined)
                  ],
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: 162,
                      height: 256,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorCollections.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 7, left: 7),
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorCollections.textPrimaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Text(
                              'Pemprov Banten mendapat Pendanaan Proyek Infrastruktur Air Banten',
                              style: HomeTextCollections.titleBerita,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Admin',
                                  style: HomeTextCollections.footerBerita,
                                ),
                                Text(
                                  '24 Mei 2024',
                                  style: HomeTextCollections.footerBerita,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: 162,
                      height: 256,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorCollections.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 7, left: 7),
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorCollections.textPrimaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Text(
                              'Pemprov Banten mendapat Pendanaan Proyek Infrastruktur Air Banten',
                              style: HomeTextCollections.titleBerita,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Admin',
                                  style: HomeTextCollections.footerBerita,
                                ),
                                Text(
                                  '24 Mei 2024',
                                  style: HomeTextCollections.footerBerita,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: 162,
                      height: 256,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorCollections.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 7, left: 7),
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorCollections.textPrimaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Text(
                              'Pemprov Banten mendapat Pendanaan Proyek Infrastruktur Air Banten',
                              style: HomeTextCollections.titleBerita,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Admin',
                                  style: HomeTextCollections.footerBerita,
                                ),
                                Text(
                                  '24 Mei 2024',
                                  style: HomeTextCollections.footerBerita,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorCollections.primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, '/form_aduan');
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: ColorCollections.textPrimaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
