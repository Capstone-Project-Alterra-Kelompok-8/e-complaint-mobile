import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/screens/home/homepage_screen.dart';
import 'package:e_complaint_app/views/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      color: ColorCollections.buttonColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home,
                color: ColorCollections.textPrimaryColor),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePageScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person,
                color: ColorCollections.textPrimaryColor),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const ProfileScreen()));
            },
          ),
        ],
      ),
    );
  }
}
