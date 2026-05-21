import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfoBox extends StatelessWidget {
  final String label;
  final String value;
  final bool showEmailIcon;

  const ProfileInfoBox({
    super.key,
    required this.label,
    required this.value,
    this.showEmailIcon = false,
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
          height: 47,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F6FC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.transparent),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: showEmailIcon
                ? Row(
              children: [
                SvgPicture.asset(
                  'assets/auth/sms.svg',
                  width: 22,
                  height: 22,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.beVietnamPro(
                      color: const Color(0xFF6F6F73),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
                : Text(
              value,
              style: GoogleFonts.beVietnamPro(
                color: const Color(0xFF6F6F73),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}