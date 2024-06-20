import 'package:e_complaint_app/views/screens/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:e_complaint_app/controllers/user_controller.dart';
import 'package:e_complaint_app/constants/constants.dart';

class ChangeProfileInputScreen extends StatefulWidget {
  const ChangeProfileInputScreen({super.key});

  @override
  State<ChangeProfileInputScreen> createState() =>
      _ChangeProfileInputScreenState();
}

class _ChangeProfileInputScreenState extends State<ChangeProfileInputScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _profilePhoto;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserController>(context, listen: false).loadUserData();
    });
  }

  @override
  void dispose() {
    _namaController.dispose();
    _telephoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePhoto = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    _namaController.text = userController.name;
    _telephoneController.text = userController.telephoneNumber;
    _emailController.text = userController.email;
    final isLoading = userController.isLoading;

    return Scaffold(
      appBar: const CurvedAppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 23, right: 23),
            child: ListView(
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    'Ubah Profile',
                    style: HomeTextCollections.headerChangeProfile,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Stack(
                    children: [
                      _profilePhoto != null
                          ? CircleAvatar(
                              radius: 75,
                              backgroundImage: FileImage(_profilePhoto!),
                            )
                          : userController.profilePhoto.isNotEmpty
                              ? CircleAvatar(
                                  radius: 75,
                                  backgroundImage:
                                      NetworkImage(userController.profilePhoto),
                                )
                              : const CircleAvatar(
                                  radius: 75,
                                  backgroundColor:
                                      ColorCollections.primaryColor,
                                  foregroundColor:
                                      ColorCollections.backgroundColor,
                                  child: Icon(Icons.person, size: 75),
                                ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 233, 237, 247),
                              
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: ColorCollections.textPrimaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Gap(10),
                _buildTextField(_namaController, 'Nama'),
                const Gap(10),
                _buildTextField(_telephoneController, 'Nomor Handphone',
                    TextInputType.phone),
                const Gap(10),
                _buildTextField(_emailController, 'Email'),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/change_profile');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Batal',
                          style: HomeTextCollections.textButtonChangeProfile,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () async {
                          await userController.changeProfile(
                            context,
                            _namaController.text,
                            _telephoneController.text,
                            _emailController.text,
                          );

                          if (_profilePhoto != null) {
                            await userController.pickImageAndUpload(
                                context, _profilePhoto!);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorCollections.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Simpan',
                          style: HomeTextCollections.textButtonChangeProfile,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: SizedBox(
                  width: 70.0,
                  height: 70.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                    backgroundColor: Colors.white,
                    strokeWidth: 7.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      [TextInputType inputType = TextInputType.text]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: LoginTextCollections.headingThree,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(
              hintText: label,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
