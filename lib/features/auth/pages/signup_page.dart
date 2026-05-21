import 'package:NoteNest/features/auth/pages/login_page.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  bool isChecked = false;
  bool loading = false;

  Future<void> signupUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() => loading = true);

    try {
      final users = await authService.signUp(
        firstName: authService.firstNameController.text.trim(),
        lastName: authService.lastNameController.text.trim(),
        email: authService.emailController.text.trim(),
        password: authService.passwordController.text.trim(),
      );

      if (users != null) {
        Get.offAll(() => HomePage());
      }
    } catch (e) {
      Get.snackbar('$e', 'please try Again');
    }

    setState(() => loading = false);
  }

  @override
  void dispose() {
    authService.firstNameController.dispose();
    authService.lastNameController.dispose();
    authService.emailController.dispose();
    authService.passwordController.dispose();
    authService.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 23),
                  child: AuthLogo(),
                ),

                const SizedBox(height: 12),

                const AuthTitle(
                  title: "Create Your Account",
                  subtitle:
                  "Start organizing your tasks and boost your productivity today.",
                ),

                const SizedBox(height: 24),

                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: AuthTextField(
                          controller: authService.firstNameController,
                          hint: "Jack",
                          label: "First Name",
                          labelFontWeight: FontWeight.w500,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AuthTextField(
                          controller: authService.lastNameController,
                          hint: "Rob",
                          label: "Last Name",
                          labelFontWeight: FontWeight.w500,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                AuthTextField(
                  label: "Email Address",
                  hint: "e.g. jackrob187@gmail.com",
                  controller: authService.emailController,
                  iconPath: 'assets/auth/sms.svg',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'email is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                AuthPasswordField(
                  label: "Password",
                  hint: "* * * * * * * * ",
                  controller: authService.passwordController,
                  obscureText: isPasswordObscured,
                  onVisibilityTap: () {
                    setState(() {
                      isPasswordObscured = !isPasswordObscured;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'password is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                AuthPasswordField(
                  label: "Confirm Password",
                  hint: "* * * * * * * * ",
                  controller: authService.confirmPasswordController,
                  obscureText: isConfirmPasswordObscured,
                  onVisibilityTap: () {
                    setState(() {
                      isConfirmPasswordObscured =
                      !isConfirmPasswordObscured;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'password is required';
                    } else if (value != authService.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isChecked = newValue ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "By continuing you agree to our ",
                            style: GoogleFonts.beVietnamPro(
                              color: const Color(0xFF737373),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: "Terms",
                                style: GoogleFonts.beVietnamPro(
                                  decoration: TextDecoration.underline,
                                  color: const Color(0xFF794098),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              const TextSpan(text: "\n&  "),
                              TextSpan(
                                text: "Policy",
                                style: GoogleFonts.beVietnamPro(
                                  decoration: TextDecoration.underline,
                                  color: const Color(0xFF794098),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                AuthButton(
                  text: loading ? "Loading..." : "Sign up",
                  onPressed: !isChecked || loading ? null : signupUser,
                ),

                const SizedBox(height: 24),

                const AuthDivider(),

                const SizedBox(height: 22.5),

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

                const SizedBox(height: 48),

                AuthBottomText(
                  normalText: "Have an account? ",
                  actionText: "Sign In",
                  onTap: () {
                    Get.to(() => const LoginPage());
                  },
                ),

                const SizedBox(height: 6.5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}