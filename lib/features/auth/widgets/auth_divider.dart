import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Or continue with",
            style: GoogleFonts.beVietnamPro(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: const Color(0xFF6F6F73),
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}