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
  final TextEditingController _firstNameController = TextEditingController(text: 'Jack');
  final TextEditingController _lastNameController = TextEditingController(text: 'Rob');
  final TextEditingController _emailController = TextEditingController(text: 'jackrob187@gmail.com');
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            CommonHeader(title: 'Profile Details'),
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 20, right: 20),
              child: Stack(
                children: [
                  Container(
                    width: 80,height: 80,
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/setting/person_image.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    right: 0,bottom: 0,
                    child: Image.asset(
                      'assets/setting/camera_icon.png',
                      height: 28,
                      width: 28,
                      fit:BoxFit.contain,

                    ),),
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
                  const SizedBox(height: 5),

                  _buildBox(
                    child: TextField(
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
                  const SizedBox(height: 5),

                  _buildBox(
                    child: TextField(
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
                  const SizedBox(height: 5),

                  _buildBox(
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "jackrob187@gmail.com",
                        prefixIcon: Icon(Icons.email_outlined),

                        contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
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
              padding: const EdgeInsets.only(bottom: 40,left: 20,right: 20),
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SettingPage()));
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

Widget _socialButton(Widget icon, String text) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      border: Border.all(color: Colors.grey.shade300),
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 8),
        Text(text),
      ],
    ),
  );
}


void _showDeleteDialog(BuildContext context) {
  showDialog(

    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Color(0xFFFFFFFF), // Your desired color
        surfaceTintColor: Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(

          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content height

            children: [
              // Trash Icon with Circular Background
              Container(
                height: 101,
                width: 101,
                decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
                child: SvgPicture.asset(
                  'assets/homepage/delete_task.svg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Delete Account',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF252526),
                ),
              ),
              const SizedBox(height: 12),

              // Subtitle
              Text(
                'Are you sure you want to delete this account? All your data will be erased.',
                textAlign: TextAlign.center,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 14,
                  color: const Color(0xFF252526),
                ),
              ),
              const SizedBox(height: 30),

              // Action Buttons
              Row(
                children: [
                  // Yes, Delete Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Add your delete logic here
                        Navigator.pop(context); // Close dialog
                      },
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),),
                                (route) =>false,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFFF3D00),
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            'Yes, Delete',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.beVietnamPro(
                              color: const Color(0xFFFF3D00),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // No, Keep it Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF794098),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'No, Keep it',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.beVietnamPro(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}


