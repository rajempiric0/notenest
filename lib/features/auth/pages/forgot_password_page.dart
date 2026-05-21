import 'package:NoteNest/features/auth/widgets/auth_back_button.dart';
import 'package:NoteNest/features/auth/widgets/auth_button.dart';
import 'package:NoteNest/features/auth/widgets/auth_text_field.dart';
import 'package:NoteNest/features/auth/widgets/auth_title.dart';
import 'package:NoteNest/features/auth/widgets/reset_password_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  bool loading = false;

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset email sent")),
      );

      showResetDialog();
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'user-not-found') {
        message = "No user found";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email";
      } else if (e.code == 'network-request-failed') {
        message = "No internet connection";
      } else {
        message = e.message ?? "Something went wrong";
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

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
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),

                  const Row(
                    children: [
                      AuthBackButton(),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const AuthTitle(
                    title: "Forgot Password",
                    subtitle:
                    "Enter your registered email below to receive password reset instructions.",
                    crossAxisAlignment: CrossAxisAlignment.start,
                    subtitleAlign: TextAlign.start,
                  ),

                  const SizedBox(height: 24),

                  AuthTextField(
                    label: "Email Address",
                    hint: "e.g. jackrob187@gmail.com",
                    controller: emailController,
                    iconPath: 'assets/auth/sms.svg',
                    keyboardType: TextInputType.emailAddress,
                    verticalPadding: 13.5,
                    labelFontWeight: FontWeight.bold,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),

                  const Spacer(),

                  AuthButton(
                    text: loading ? "Loading..." : "Continue",
                    backgroundColor: const Color(0xff7A49A5),
                    fontWeight: FontWeight.bold,
                    onPressed: loading ? null : resetPassword,
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}