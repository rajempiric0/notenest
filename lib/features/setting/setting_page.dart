import 'package:NoteNest/features/bottom_navigation_bar.dart'
    show CustomBottomBar;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:NoteNest/features/setting/header.dart';
import 'package:NoteNest/features/setting/language_page.dart';
import 'package:NoteNest/features/setting/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../auth/login_page.dart';
import '../dashboard/screens/home_controller.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F6FC),
      bottomNavigationBar: CustomBottomBar(currentIndex: 1),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserData(),
          builder: (context, snapshot) {
            String fullName = '';
            String email = FirebaseAuth.instance.currentUser?.email ?? '';

            if (snapshot.hasData && snapshot.data!.exists) {
              final data = snapshot.data!.data();

              fullName =
                  '${data?['firstName'] ?? ''} ${data?['lastName'] ?? ''}';
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: CommonHeader(title: "Settings"),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(ProfilePage());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            child: Image.asset(
                              'assets/setting/person_image.png',
                              width: 52,
                              height: 52,
                            ),
                          ),
                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fullName,
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2E2E32),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  email,
                                  style: GoogleFonts.beVietnamPro(
                                    color: Color(0xFF6A6B73),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(LanguagePage());
                          },

                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SvgPicture.asset(
                                  'assets/setting/translate.svg',
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Language",
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF252526),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Divider(color: Colors.grey.shade300),
                        const SizedBox(height: 16),

                        GestureDetector(
                          onTap: () {
                            _showDeleteDialog(context);
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'assets/setting/logout.svg',
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Log out",

                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

void _showDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Color(0xFFFFFFFF), // Your desired color
        surfaceTintColor: Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
                child: Image.asset(
                  'assets/setting/setting_delete.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              Text(
                'Log out?',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF252526),
                ),
              ),
              const SizedBox(height: 12),

              // Subtitle
              Text(
                'Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 14,
                  color: const Color(0xFF252526),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Get.delete<HomeController>();
                          Get.offAll(() => LoginPage());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFFF3D00)),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            'Yes',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 14,
                              color: const Color(0xFFFF3D00),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: GestureDetector(
                      onTap: () =>Get.back(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF794098),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.beVietnamPro(
                            color: Colors.white,
                            fontSize: 14,
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
