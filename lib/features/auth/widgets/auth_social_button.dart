import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthSocialButton extends StatelessWidget {
  final Widget icon;
  final String text;

  const AuthSocialButton({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.beVietnamPro(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF262626),
            ),
          ),
        ],
      ),
    );
  }
}