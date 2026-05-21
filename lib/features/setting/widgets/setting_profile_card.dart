import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingProfileCard extends StatelessWidget {
  final String fullName;
  final String email;
  final VoidCallback onTap;

  const SettingProfileCard({
    super.key,
    required this.fullName,
    required this.email,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                      color: const Color(0xFF2E2E32),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: GoogleFonts.beVietnamPro(
                      color: const Color(0xFF6A6B73),
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
    );
  }
}