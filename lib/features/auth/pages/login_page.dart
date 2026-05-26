import 'package:NoteNest/features/auth/pages/forgot_password_page.dart';
import 'package:NoteNest/features/auth/pages/signup_page.dart';
import 'package:NoteNest/features/auth/services/auth_service.dart';
import 'package:NoteNest/features/auth/widgets/auth_bottom_text.dart';
import 'package:NoteNest/features/auth/widgets/auth_button.dart';
import 'package:NoteNest/features/auth/widgets/auth_divider.dart';
import 'package:NoteNest/features/auth/widgets/auth_logo.dart';
import 'package:NoteNest/features/auth/widgets/auth_password_field.dart';
import 'package:NoteNest/features/auth/widgets/auth_social_button.dart';
import 'package:NoteNest/features/auth/widgets/auth_text_field.dart';
import 'package:NoteNest/features/auth/widgets/auth_title.dart';
import 'package:NoteNest/features/dashboard/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  bool isObscured = true;

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() => loading = true);

    try {
      final user = await authService.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (user != null) {
        Get.offAll(() => HomePage());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(e.message ?? 'Login failed', 'try again');

      if (e.code == 'user-not-found') {
        Get.snackbar('User not found', 'try again');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Enter Valid password', 'try again');
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Verify Email', 'try again');
      }
    }

    setState(() => loading = false);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 18),
                  child: AuthLogo(),
                ),

                const SizedBox(height: 12),

                const AuthTitle(
                  title: "Welcome Back!",
                  subtitle:
                  "Sign in to continue managing your tasks and stay organized.",
                ),

                const SizedBox(height: 24),

                AuthTextField(
                  label: "Email Address",
                  hint: "e.g. jackrob187@gmail.com",
                  validator: Validators.email,
                  controller: emailController,
                  iconPath: 'assets/auth/sms.svg',
                  keyboardType: TextInputType.emailAddress,

                ),

                const SizedBox(height: 12),

                AuthPasswordField(
                  label: "Password",
                  hint: "* * * * * * * * ",
                  controller: passwordController,
                  obscureText: isObscured,
                  onVisibilityTap: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                  validator: (value) {
                    return Validators.confirmPassword(
                      value,
                      passwordController.text,
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const ForgotPasswordPage());
                      },
                      child: Text(
                        "Forgot password?",
                        style: GoogleFonts.beVietnamPro(
                          color: const Color(0xFF794098),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 25.5),
                  child: AuthButton(
                    text: loading ? "Loading..." : "Log In",
                    onPressed: loading ? null : loginUser,
                  ),
                ),

                const SizedBox(height: 24),

                const AuthDivider(),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: AuthSocialButton(
                        icon: SvgPicture.asset(
                          'assets/auth/google.svg',
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                        text: "Google",
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: AuthSocialButton(
                        icon: Icon(Icons.apple),
                        text: "Apple",
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 84),
                  child: AuthBottomText(
                    normalText: "Don’t have an account? ",
                    actionText: "Sign Up",
                    onTap: () {
                      Get.to(() => const SignUpPage());
                    },
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}