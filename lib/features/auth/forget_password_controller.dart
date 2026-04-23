import 'package:NoteNest/features/auth/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  void showResetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const ResetPasswordDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 18),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 22.5,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Color.fromARGB(255, 246, 244, 244),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: 18,
                          ),
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Text(
                      // Title
                      "Forgot Password",
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF262626),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Center(
                  child: Text(
                    "Enter your registered email below to receive password reset instructions.",
                    style: GoogleFonts.beVietnamPro(
                      color: Color(0xFF6F6F73),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        //Email
                        "Email Address",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Container(
                  //Email Container
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6F6F73),
                    ),
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 13.5),
                      icon: SvgPicture.asset(
                        'assets/auth/sms.svg',
                        width: 22,
                        height: 22,
                        fit: BoxFit.cover,
                      ),
                      hintText: "e.g. jackrob187@gmail.com",
                      hintStyle: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6F6F73),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const Spacer(),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: showResetDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff7A49A5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
