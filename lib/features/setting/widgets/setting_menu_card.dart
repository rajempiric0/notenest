import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingMenuCard extends StatelessWidget {
  final VoidCallback onLanguageTap;
  final VoidCallback onLogoutTap;

  const SettingMenuCard({
    super.key,
    required this.onLanguageTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onLanguageTap,
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
                    "Language".tr,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF252526),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 16),

          GestureDetector(
            onTap: onLogoutTap,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'assets/setting/logout.svg',
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Log out".tr,
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
    );
  }
}