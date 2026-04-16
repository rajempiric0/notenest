import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordDialog extends StatelessWidget {
  const ResetPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(

          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Image

            Container(
              padding: EdgeInsetsGeometry.all(8),

              alignment: Alignment.center,
              decoration: const BoxDecoration(),
              child: SvgPicture.asset(
                'assets/auth/forgot_pass.svg',
                width: 133,
                height: 117,
                fit: BoxFit.cover,
              )

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
                color: Color(0xFF6F6F73),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            // Back Button
            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7A49A5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Back To Login",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.beVietnamPro(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
