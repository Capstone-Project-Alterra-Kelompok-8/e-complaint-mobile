import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/auth_controller.dart';
import 'package:e_complaint_app/controllers/profile_controller.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/components/bottom_navbar.dart';
import 'package:e_complaint_app/views/screens/home/aboutapp_screen.dart';
import 'package:e_complaint_app/views/screens/home/chanepassword_screen.dart';
import 'package:e_complaint_app/views/screens/home/changeprofile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileController>(context, listen: false).loadUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    return Scaffold(
      appBar: const CurvedAppBar(),
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          const Center(
            child: CircleAvatar(
              radius: 45,
              backgroundColor: ColorCollections.primaryColor,
              foregroundColor: ColorCollections.backgroundColor,
              child: Icon(Icons.person),
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  profileController.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: ColorCollections.textPrimaryColor,
                      fontSize: 16),
                ),
                Text(
                  profileController.email,
                  style: const TextStyle(
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
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/change_profile');
            },
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: const BoxDecoration(
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
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/change_password_profile');
            },
            child: SizedBox(
              width: double.infinity,
              height: 70,
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
          ),
          const Divider(),
          GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: double.infinity,
              height: 70,
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
          ),
          const Divider(),
          GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: double.infinity,
              height: 70,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.category_outlined),
                    color: ColorCollections.textPrimaryColor,
                  ),
                  const Text(
                    'Riwayat Favorit',
                    style: TextStyle(
                      color: ColorCollections.textPrimaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/aboutApp');
            },
            child: SizedBox(
              width: double.infinity,
              height: 70,
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
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              final logoutController = Provider.of<LoginAuthController>(
                context,
                listen: false,
              );
              logoutController.logout(context);
            },
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
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
