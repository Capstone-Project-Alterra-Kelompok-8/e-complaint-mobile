import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:flutter/material.dart';

class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({super.key});

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 75,
                  backgroundColor: ColorCollections.primaryColor,
                  foregroundColor: ColorCollections.backgroundColor,
                  child: Icon(Icons.person, size: 75),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Implementasikan logika untuk ganti foto profil
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: ColorCollections.primaryColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
              width: double.infinity,
              height: 70,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  'Name',
                  style: HomeTextCollections.titleButton,
                ),
                subtitle: const Text('Maulana Abraham'),
                trailing: const CircleAvatar(
                    backgroundColor: ColorCollections.profileButtonColor,
                    child: Icon(Icons.edit_outlined)),
              )),
          const Divider(),
          SizedBox(
              width: double.infinity,
              height: 70,
              child: ListTile(
                leading: const Icon(Icons.info),
                title: Text(
                  'About',
                  style: HomeTextCollections.titleButton,
                ),
                subtitle: const Text('Single'),
                trailing: const CircleAvatar(
                    backgroundColor: ColorCollections.profileButtonColor,
                    child: Icon(Icons.edit_outlined)),
              )),
          const Divider(),
          SizedBox(
              width: double.infinity,
              height: 70,
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: Text(
                  'Phone Number',
                  style: HomeTextCollections.titleButton,
                ),
                subtitle: const Text('081212345678'),
                trailing: const CircleAvatar(
                    backgroundColor: ColorCollections.profileButtonColor,
                    child: Icon(Icons.edit_outlined)),
              )),
          const Divider(),
          Container(
              width: double.infinity,
              height: 70,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: ListTile(
                leading: const Icon(Icons.email),
                title: Text(
                  'Email',
                  style: HomeTextCollections.titleButton,
                ),
                subtitle: const Text('maulanaabrhm@gmail.com'),
                trailing: const CircleAvatar(
                    backgroundColor: ColorCollections.profileButtonColor,
                    child: Icon(Icons.edit_outlined)),
              )),
        ],
      ),
    );
  }
}
