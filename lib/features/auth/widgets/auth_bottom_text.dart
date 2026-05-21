import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthBottomText extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback onTap;

  const AuthBottomText({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          normalText,
          style: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: const Color(0xFF6F6F73),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: GoogleFonts.beVietnamPro(
              color: const Color(0xFF794098),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}