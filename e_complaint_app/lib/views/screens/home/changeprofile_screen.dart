import 'package:e_complaint_app/constants/constants.dart';
import 'package:e_complaint_app/controllers/user_controller.dart';
import 'package:e_complaint_app/controllers/profile_controller.dart';
import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({super.key});

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
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
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Stack(
              children: [
                userController.profilePhotoUrl.isNotEmpty
                    ? CircleAvatar(
                        radius: 75,
                        backgroundImage:
                            NetworkImage(userController.profilePhotoUrl),
                      )
                    : const CircleAvatar(
                        radius: 75,
                        backgroundColor: ColorCollections.primaryColor,
                        foregroundColor: ColorCollections.backgroundColor,
                        child: Icon(Icons.person, size: 75),
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
                subtitle: Text(userController.name),
              )),
          Container(height: 5, child: const Divider()),
          SizedBox(
              width: double.infinity,
              height: 70,
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: Text(
                  'Phone Number',
                  style: HomeTextCollections.titleButton,
                ),
                subtitle: Text(userController.telephoneNumber),
              )),
          Container(height: 5, child: const Divider()),
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
                subtitle: Text(userController.email),
              )),
          SizedBox(
            height: 60,
          ),
          Container(
            width: 170,
            height: 52,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/change_profile_input');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Ubah Profile',
                      style:
                          TextStyle(color: ColorCollections.textPrimaryColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorCollections.profileButtonColor,
                      ),
                      child: Icon(Icons.edit_outlined),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
