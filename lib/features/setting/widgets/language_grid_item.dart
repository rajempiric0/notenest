import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageGridItem extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageGridItem({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 161,
        height: 42,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0x1A794098)
              : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF794098)
                : const Color(0xFFE5E5E5),
            width: 1,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.beVietnamPro(
                fontSize: 13,
                color: const Color(0xFF262626),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}