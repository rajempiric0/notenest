import 'package:NoteNest/features/setting/pages/edit_profile_page.dart';
import 'package:NoteNest/features/setting/services/profile_service.dart';
import 'package:NoteNest/features/setting/widgets/delete_account_dialog.dart';
import 'package:NoteNest/features/setting/widgets/profile_info_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileService profileService = ProfileService();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: profileService.getUserData(),
          builder: (context, snapshot) {
            final data = snapshot.data?.data();

            final String email =
                profileService.auth.currentUser?.email ?? '';
            final String firstName = data?['firstName'] ?? '';
            final String lastName = data?['lastName'] ?? '';

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      CommonHeader(title: 'profile_details'.tr),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => const EditProfilePage());
                            },
                            child: Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
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
                  padding: const EdgeInsets.only(
                    top: 24,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileInfoBox(
                        label: 'First Name',
                        value: firstName,
                      ),
                      const SizedBox(height: 12),

                      ProfileInfoBox(
                        label: 'Last Name',
                        value: lastName,
                      ),
                      const SizedBox(height: 12),

                      ProfileInfoBox(
                        label: 'Email Address',
                        value: email,
                        showEmailIcon: true,
                      ),
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
                      showDeleteAccountDialog(context);
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
                        'delete_account'.tr,
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