import 'package:NoteNest/features/auth/signup_page.dart';
import 'package:NoteNest/features/setting/setting_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'header.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _firstNameController = TextEditingController(
    text: 'Jack',
  );
  final TextEditingController _lastNameController = TextEditingController(
    text: 'Rob',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'jackrob187@gmail.com',
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
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
                    child: TextField(
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF6F6F73),
                      ),

                      controller: _firstNameController,
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
                    child: TextField(
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF6F6F73),
                      ),
                      controller: _lastNameController,
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
                    child: TextField(
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF6F6F73),
                      ),

                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "jackrob187@gmail.com",
                        prefixIcon: Icon(Icons.email_outlined),

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 10,
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
              padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SettingPage()),
                    );
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
