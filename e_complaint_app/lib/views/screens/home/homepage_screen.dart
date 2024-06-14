import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/my_complaint_controller.dart';
import 'package:e_complaint_app/controllers/news_controller.dart';
import 'package:e_complaint_app/controllers/user_controller.dart';
import 'package:e_complaint_app/views/screens/components/bottom_navbar.dart';
import 'package:e_complaint_app/views/screens/news/components/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserController>(context, listen: false).loadUserData();
      Provider.of<NewsController>(context, listen: false).getNews();
      Provider.of<MyComplaintController>(context, listen: false).getMyComplaint();
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsController = Provider.of<NewsController>(context);
    final userController = Provider.of<UserController>(context);
    final isLoaded = Provider.of<NewsController>(context).isLoaded;
    final myComplaintController = Provider.of<MyComplaintController>(context);
    if (!myComplaintController.isLoaded) {
      myComplaintController.getMyComplaint();
    }
    
   
                  

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorCollections.buttonColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(image: AssetImage('assets/images/logo_appbar.png')),
            IconButton(onPressed: (){
              Navigator.pushNamed(context, '/notification');
            },
              icon: Icon(Icons.notifications_none_outlined, size: 35)),
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
                        const SizedBox(height: 8.0),
                        Text(userController.name,
                            style: HomeTextCollections.nameText),
                      ],
                    ),
                  ),
                  userController.profilePhoto.isNotEmpty
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(userController.profilePhoto),
                        )
                      : const CircleAvatar(
                          radius: 40,
                          backgroundColor: ColorCollections.textPrimaryColor,
                        )
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
                  labelText: 'Cari...',
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
                onTap: () {
                  Navigator.pushNamed(context, '/my_complaint');
                 
                  
                },
                child: const Column(
                  children: [
                    SizedBox(
                        child: Image(
                            image:
                                AssetImage('assets/images/icon_aduanku.png'))),
                    Text('Aduanku'),
                    Text('')
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  
                },
                child: const Column(
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
                onTap: () {
                  
                },
                child: const Column(
                  children: [
                    Image(
                        image: AssetImage('assets/images/icon_chat_admin.png')),
                    Text('Chat'),
                    Text('Admin')
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Column(
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
                Row(
                  children: [
                    Text('Lihat Semua'),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/news');
                        },
                        icon: Icon(Icons.chevron_right_outlined)),
                  ],
                )
              ],
            ),
          ),
          isLoaded
              ? (newsController.news.isNotEmpty
                  ? GridView.builder(
                      controller: ScrollController(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 12 / 19,
                      ),
                      shrinkWrap: true,
                      itemCount: newsController.news.length,
                      itemBuilder: (context, index) {
                        return NewsCard(news: newsController.news[index]);
                      },
                    )
                  : const Center(
                      child: Text(
                        'Tidak ada berita yang ditampilkan',
                        style: TextStyle(fontSize: 16),
                      ),
                    ))
              : const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                    backgroundColor: Colors.white,
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
