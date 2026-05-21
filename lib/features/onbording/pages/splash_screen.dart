import 'dart:async';
import 'package:NoteNest/features/onbording/pages/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../dashboard/pages/home_page.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    _navigateToOnboarding();
  }

  void _navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 3));

    final uid = FirebaseAuth.instance.currentUser?.uid;


    if (uid != null && uid.isNotEmpty) {
      Get.offAll(() => HomePage());
    } else {
      Get.offAll(() => OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF794098),
      body: Align(
        // alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/logo/logo.svg',
              width: 160,
              height: 160,
              semanticsLabel: 'Company Logo',
            ),
            Text(
              'NoteNest',
              style: GoogleFonts.beVietnamPro(
                fontSize: 32,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
