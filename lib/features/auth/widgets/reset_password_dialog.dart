import 'package:NoteNest/features/auth/pages/login_page.dart';
import 'package:NoteNest/features/auth/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordDialog extends StatelessWidget {
  const ResetPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/auth/forgot_pass.svg',
                width: 133,
                height: 117,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Reset Password",
              textAlign: TextAlign.center,
              style: GoogleFonts.beVietnamPro(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "A password reset link has been sent to your email. "
                  "Check your inbox and spam folder to reset your password.",
              textAlign: TextAlign.center,
              style: GoogleFonts.beVietnamPro(
                fontSize: 14,
                color: const Color(0xFF6F6F73),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            AuthButton(
              text: "Back To Login",
              backgroundColor: const Color(0xff7A49A5),
              fontWeight: FontWeight.bold,
              onPressed: () {
                Get.offAll(() => const LoginPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}