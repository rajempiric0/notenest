import 'package:NoteNest/features/setting/pages/setting_page.dart';
import 'package:NoteNest/features/setting/services/profile_service.dart';
import 'package:NoteNest/features/setting/widgets/edit_profile_image.dart';
import 'package:NoteNest/features/setting/widgets/edit_profile_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/header.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ProfileService profileService = ProfileService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isLoading = true;

  Future<void> fetchProfileData() async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
    await profileService.getUserData();

    if (doc.exists) {
      final data = doc.data();

      firstNameController.text = data?['firstName'] ?? '';
      lastNameController.text = data?['lastName'] ?? '';
      emailController.text = data?['email'] ?? '';
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> updateProfileData() async {
    await profileService.updateProfile(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: CommonHeader(title: 'profile_details'.tr),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 35, left: 20, right: 20),
                child: EditProfileImage(),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditProfileTextField(
                      label: 'First Name',
                      controller: firstNameController,
                    ),
                    const SizedBox(height: 12),

                    EditProfileTextField(
                      label: 'Last Name',
                      controller: lastNameController,
                    ),
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
                      if (formKey.currentState!.validate()) {
                        await updateProfileData();
                        Get.offAll(() => SettingPage());
                      }
                    },
                    child: Text(
                      'save_changes'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
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