import 'package:NoteNest/features/common/bottom_navigation_bar.dart';
import 'package:NoteNest/features/setting/pages/language_page.dart';
import 'package:NoteNest/features/setting/pages/profile_page.dart';
import 'package:NoteNest/features/setting/services/profile_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/header.dart';
import '../widgets/logout_dialog.dart';
import '../widgets/setting_menu_card.dart';
import '../widgets/setting_profile_card.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final ProfileService profileService = ProfileService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FC),
      bottomNavigationBar: const CustomBottomBar(currentIndex: 1),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: profileService.getUserData(),
          builder: (context, snapshot) {
            String fullName = '';
            String email = profileService.auth.currentUser?.email ?? '';

            if (snapshot.hasData && snapshot.data!.exists) {
              final data = snapshot.data!.data();
              fullName =
              '${data?['firstName'] ?? ''} ${data?['lastName'] ?? ''}';
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: CommonHeader(title: "settings".tr),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                  child: SettingProfileCard(
                    fullName: fullName,
                    email: email,
                    onTap: () {
                      Get.to(() => const ProfilePage());
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: SettingMenuCard(
                    onLanguageTap: () {
                      Get.to(() => const LanguagePage());
                    },
                    onLogoutTap: () {
                      showLogoutDialog(context);
                    },
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