import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const EditProfileTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w500,
            color: const Color(0xFF262626),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),

        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E2E2)),
          ),
          child: TextFormField(
            controller: controller,
            style: GoogleFonts.beVietnamPro(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: const Color(0xFF6F6F73),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'this field is required';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintStyle: GoogleFonts.beVietnamPro(
                color: const Color(0xFFE2E2E2),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}