import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/home_controller.dart';

class HomeSearchBar extends StatelessWidget {
  final HomeController controller;
  final TextEditingController searchController;

  const HomeSearchBar({
    super.key,
    required this.controller,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Image.asset('assets/homepage/search_icon.png', height: 20, width: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: controller.changeSearch,
              style: GoogleFonts.beVietnamPro(
                color: const Color(0xFF777777),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'search_tasks'.tr,

                border: InputBorder.none,
                hintStyle: GoogleFonts.beVietnamPro(
                  color: const Color(0xFF777777),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
