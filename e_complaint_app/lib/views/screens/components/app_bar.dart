import 'package:e_complaint_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {


  const CurvedAppBar({Key? key}) : super(key: key);

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
          gradient: LinearGradient(
            colors: [ColorCollections.primaryColor, ColorCollections.backgroundColor], // Define your gradient colors here
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),

        ),
        child: Image(
            image: AssetImage('assets/images/logo_appbar.png'),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}