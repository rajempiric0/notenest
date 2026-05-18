import 'package:NoteNest/features/auth/signup_page.dart';
import 'package:NoteNest/features/setting/edit_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
final uid = FirebaseAuth.instance.currentUser!.uid;

Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
  return FirebaseFirestore.instance.collection('users').doc(uid).get();
}

Future<void> deleteUser() async{
  final user = FirebaseAuth.instance.currentUser;
  final uid = user!.uid;


  await FirebaseFirestore.instance.collection('users').doc(uid).delete();

  await user.delete();

}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserData(),
          builder: (context, snapshot) {
            final data = snapshot.data!.data() as Map<String, dynamic>;

            String email = FirebaseAuth.instance.currentUser?.email ?? '';
            final String firstName = data['firstName'] ?? '';
            final String lastName = data['lastName'] ?? '';

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 36, left: 20),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFE5E2E3),
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 24,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                      // Title
                      Center(
                        child: Text(
                          'Profile Details',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.only(right: 20),

                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(EditProfilePage());
                            },

                            child: Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFE5E2E3),

                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/homepage/edit.svg',
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28, left: 20, right: 20),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/setting/person_image.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    top: 24,
                    left: 20,
                    right: 20,
                  ),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Text(
                            firstName,
                            style: GoogleFonts.beVietnamPro(
                              color: Color(0xFF6F6F73),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Text(
                            lastName,
                            style: GoogleFonts.beVietnamPro(
                              color: Color(0xFF6F6F73),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/auth/sms.svg',
                                width: 22,
                                height: 22,
                                fit: BoxFit.contain,

                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  email,

                                  style: GoogleFonts.beVietnamPro(
                                    color: Color(0xFF6F6F73),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 8,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _showDeleteDialog(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: const Color(0xFFFF3D00)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Delete Account",
                        style: GoogleFonts.beVietnamPro(
                          color: const Color(0xFFFF3D00),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
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

Widget _buildBox({required Padding child}) {
  return Container(
    height: 47,
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFFF7F6FC),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.transparent),
    ),
    child: child,
  );
}

void _showDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Color(0xFFFFFFFF),
        surfaceTintColor: Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
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
              const SizedBox(height: 28),

              Text(
                'Delete Account',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF252526),
                ),
              ),
              const SizedBox(height: 8),

              Text(
                'Are you sure you want to delete this account? All your data will be erased.',
                textAlign: TextAlign.center,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF252526),
                ),
              ),
              const SizedBox(height: 28),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: InkWell(
                        onTap: () async{
                          await deleteUser();
                          Get.offAll(SignUpPage());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFFF3D00)),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            'Yes, Delete',
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
                      onTap: () => Get.back(),
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
                            fontSize: 14,
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
