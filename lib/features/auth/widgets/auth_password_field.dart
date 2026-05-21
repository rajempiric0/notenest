import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPasswordField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onVisibilityTap;
  final String? Function(String?)? validator;

  const AuthPasswordField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.obscureText,
    required this.onVisibilityTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF262626),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            style: GoogleFonts.beVietnamPro(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6F6F73),
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 5,
              ),
              icon: SvgPicture.asset(
                'assets/auth/lock.svg',
                width: 22,
                height: 22,
                fit: BoxFit.cover,
              ),
              hintText: hint,
              hintStyle: GoogleFonts.beVietnamPro(
                fontSize: 14,
                color: const Color(0xFF6F6F73),
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: onVisibilityTap,
                icon: obscureText
                    ? const Icon(Icons.remove_red_eye_outlined)
                    : const Icon(Icons.visibility_off_outlined),
              ),
            ),
          ),
        ),
      ],
    );
  }
}