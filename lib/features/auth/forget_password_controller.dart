import 'package:NoteNest/features/auth/reset_password.dart';
import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                const SizedBox(height: 20),

                CircleAvatar(                   // Back Button
                radius: 24,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 24),color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Center(
                  child: Text(            // Title
                    "Forgot Password",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ),


                const SizedBox(height: 10),

                Center(
                  child: Text(
                    "Enter your registered email below to receive password reset instructions.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.beVietnamPro(
                      color: Color(0xFF6F6F73),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 30),


                Text(         //Email
                  "Email Address",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                const SizedBox(height: 10),

                Container(                         //Email Container
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mail_outline),
                      hintText: "e.g. jackrob187@gmail.com",
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
                      "Continue",textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white

                      ),
                    ),
                  ),
                  ),


                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
