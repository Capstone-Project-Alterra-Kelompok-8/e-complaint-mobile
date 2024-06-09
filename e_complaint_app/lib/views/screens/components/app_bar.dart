import 'package:e_complaint_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CurvedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(48.0),
            bottomRight: Radius.circular(48.0),
          ),
          child: Container(
            height: 106,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorCollections.primaryColor, ColorCollections.backgroundColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Image(
              image: AssetImage('assets/images/logo appbar.png'),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 0,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}



class CurvedAppBarMyComplaint extends StatelessWidget implements PreferredSizeWidget {
  const CurvedAppBarMyComplaint({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(48.0),
            bottomRight: Radius.circular(48.0),
          ),
          child: Container(
            height: 106,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorCollections.primaryColor, ColorCollections.backgroundColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Image(
              image: AssetImage('assets/images/logo appbar.png'),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 0,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
