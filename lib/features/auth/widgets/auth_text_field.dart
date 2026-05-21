import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? iconPath;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final double verticalPadding;
  final FontWeight labelFontWeight;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.iconPath,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.verticalPadding = 13,
    this.labelFontWeight = FontWeight.w400,
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
            fontWeight: labelFontWeight,
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
            keyboardType: keyboardType,
            validator: validator,
            style: GoogleFonts.beVietnamPro(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6F6F73),
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: iconPath == null ? 16 : 0,
              ),
              icon: iconPath == null
                  ? null
                  : SvgPicture.asset(
                iconPath!,
                width: 22,
                height: 22,
                fit: BoxFit.cover,
              ),
              hintText: hint,
              hintStyle: GoogleFonts.beVietnamPro(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6F6F73),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}