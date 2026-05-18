import 'package:NoteNest/features/setting/setting_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'header.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? docId;
  bool isLoading = true;

  final _formkey = GlobalKey<FormState>();
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Future<void> fetchTaskData() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;

      _firstNameController.text = data['firstName'] ?? '';
      _lastNameController.text = data['lastName'] ?? '';
      _emailController.text = data['email'] ?? '';
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    docId = uid;
    fetchTaskData();
  }

  Future<void> updateTaskData() async {
    if (docId == null) return;

    await FirebaseFirestore.instance.collection('users').doc(docId).update({
      'email': _emailController.text.trim(),
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
    });
  }


  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Form(
            key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: CommonHeader(title: 'Profile Details'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
                child: Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/setting/person_image.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        'assets/setting/camera_icon.png',
                        height: 28,
                        width: 28,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(top: 24, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'First Name',
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF262626),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),

                    _buildBox(
                      child: TextFormField(
                        style: GoogleFonts.beVietnamPro(
                          fontWeight: FontWeight.w400,

                          fontSize: 14,
                          color: Color(0xFF6F6F73),
                        ),

                        controller: _firstNameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintStyle: GoogleFonts.beVietnamPro(
                            color: Color(0xFFE2E2E2),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      'Last Name',
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF262626),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),

                    _buildBox(
                      child: TextFormField(
                        style: GoogleFonts.beVietnamPro(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF6F6F73),
                        ),
                        controller: _lastNameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintStyle: GoogleFonts.beVietnamPro(
                            color: Color(0xFF6F6F73),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      'Email Address',
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF262626),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),

                    _buildBox(
                      child: TextFormField(
                        style: GoogleFonts.beVietnamPro(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF6F6F73),
                        ),

                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'email is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "jackrob187@gmail.com",
                          prefixIcon: SvgPicture.asset(
                            'assets/auth/sms.svg',
                            width: 5,
                            height: 8,
                            fit: BoxFit.none,
                          ),

                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),


                          hintStyle: GoogleFonts.beVietnamPro(
                            color: Color(0xFF6F6F73),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF794098),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await updateTaskData();

                        Get.offAll(SettingPage());
                      }
                    },
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildBox({required child}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE2E2E2)),
    ),
    child: child,
  );
}
