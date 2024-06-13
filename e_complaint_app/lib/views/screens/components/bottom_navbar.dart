import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/screens/home/homepage_screen.dart';
import 'package:e_complaint_app/views/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

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
            icon: currentRoute == '/home'
                ? CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.home_outlined,
                        color: ColorCollections.textPrimaryColor),
                  )
                : Icon(Icons.home_outlined,
                    color: ColorCollections.textPrimaryColor),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePageScreen(),
                  settings: RouteSettings(name: '/home'),
                ),
              );
            },
          ),
          IconButton(
            icon: currentRoute == '/profile'
                ? CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person_2_outlined,
                        color: ColorCollections.textPrimaryColor),
                  )
                : Icon(Icons.person_2_outlined,
                    color: ColorCollections.textPrimaryColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                  settings: RouteSettings(name: '/profile'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
