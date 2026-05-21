import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeHeader extends StatelessWidget {
  final HomeController controller;

  const HomeHeader({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${'Hello'.tr}, ${controller.firstName.value} 👋',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.beVietnamPro(
            fontSize: 18,
            color: const Color(0xFF262626),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'today_line'.tr,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.mukta(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF777777),
          ),
        ),
      ],
    );
  }
}