import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const CommonHeader({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.only(top: 20,left: 20),
      child: Row(
        children: [

          CircleAvatar(
            radius: 22.5,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              radius: 22,

              backgroundColor: const Color.fromARGB(255, 246, 244, 244),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 18,
                ),
                color: Colors.black,
                onPressed: onBack ?? () => Navigator.pop(context),
              ),
            ),
          ),
          const Spacer(),

          Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.beVietnamPro(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

          const Spacer(), // to keep text centered
        ],
      ),
    );
  }
}