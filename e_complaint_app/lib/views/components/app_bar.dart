import 'package:e_complaint_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {


  const CurvedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(48.0),
        bottomRight: Radius.circular(48.0),
      ),
      child: Container(
        height: 106,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ColorCollections.primaryColor, ColorCollections.backgroundColor], // Define your gradient colors here
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],

        ),
        child: const Image(
            image: AssetImage('assets/images/logo appbar.png'),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}