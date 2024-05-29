import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/components/bottom_navbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(),
      body: ListView(
        children: [
          const SizedBox(
            height: 18,
          ),
          const Center(
            child: CircleAvatar(
              radius: 45,
              backgroundColor: ColorCollections.primaryColor,
              foregroundColor: ColorCollections.backgroundColor,
              child: Icon(Icons.person),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Column(
              children: [
                Text(
                  'Maulana Abraham',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: ColorCollections.textPrimaryColor,
                      fontSize: 16),
                ),
                Text(
                  'maulanaabrhm@gmail.com',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: ColorCollections.textPrimaryColor,
                      fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 33,
          ),
          Container(
            width: double.infinity,
            height: 70,
            decoration: const BoxDecoration(
              color: ColorCollections.profileColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person_2_outlined),
                  color: ColorCollections.textPrimaryColor,
                ),
                const Text(
                  'Ubah Profile',
                  style: TextStyle(
                    color: ColorCollections.textPrimaryColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            color: ColorCollections.profileColor,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.key_outlined),
                  color: ColorCollections.textPrimaryColor,
                ),
                const Text(
                  'Ubah Password',
                  style: TextStyle(
                    color: ColorCollections.textPrimaryColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            color: ColorCollections.profileColor,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mode_comment_outlined),
                  color: ColorCollections.textPrimaryColor,
                ),
                const Text(
                  'Laporan Saya',
                  style: TextStyle(
                    color: ColorCollections.textPrimaryColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            color: ColorCollections.profileColor,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.category_outlined),
                  color: ColorCollections.textPrimaryColor,
                ),
                const Text(
                  'Kategori Populer',
                  style: TextStyle(
                    color: ColorCollections.textPrimaryColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            color: ColorCollections.profileColor,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                  color: ColorCollections.textPrimaryColor,
                ),
                const Text(
                  'Tentang Kami',
                  style: TextStyle(
                    color: ColorCollections.textPrimaryColor,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              height: 70,
              color: ColorCollections.profileColor,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.logout),
                    color: ColorCollections.textPrimaryColor,
                  ),
                  const Text(
                    'Logout',
                    style: TextStyle(
                      color: ColorCollections.textPrimaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorCollections.primaryColor,
        onPressed: () {},
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
