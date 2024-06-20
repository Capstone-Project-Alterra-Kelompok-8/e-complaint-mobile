import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/auth_controller.dart';
import 'package:e_complaint_app/controllers/user_controller.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:e_complaint_app/views/screens/components/bottom_navbar.dart';
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
      Provider.of<UserController>(context, listen: false).loadUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    return Scaffold(
      appBar: const CurvedAppBar(),
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          const SizedBox(
            height: 35,
          ),
          Center(
            child: userController.profilePhoto.isNotEmpty ? CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(userController.profilePhoto),
            ) :
            const CircleAvatar(
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
                  userController.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: ColorCollections.textPrimaryColor,
                      fontSize: 16),
                ),
                Text(
                  userController.email,
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
          const SizedBox(
            height: 5,
            child: Divider(),
          ),
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
          const SizedBox(
            height: 5,
            child: Divider(),
          ),
          GestureDetector(
            onTap: () {
               Navigator.pushNamed(context, '/my_complaint');
            },
            child: SizedBox(
              width: double.infinity,
              height: 70,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/my_complaint');
                    },
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
          const SizedBox(
            height: 5,
            child: Divider(),
          ),
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
          const SizedBox(
            height: 5,
            child: Divider(),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/about_App');
            },
            child: SizedBox(
              width: double.infinity,
              height: 70,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                       Navigator.pushNamed(context, '/about_App');
                    },
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
          const SizedBox(
            height: 5,
            child: Divider(),
          ),
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
                    onPressed: () {
                      final logoutController = Provider.of<LoginAuthController>(
                        context,
                        listen: false,
                      );
                      logoutController.logout(context);
                    },
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
