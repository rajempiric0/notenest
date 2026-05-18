import 'package:NoteNest/features/auth/auth_service.dart';
import 'package:NoteNest/features/auth/signup_page.dart';
import 'package:NoteNest/features/dashboard/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool loading = false;

  late var _isObscured = true;
  void loginUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => loading = true);

    try {
      final user = await _authService.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (user != null) {
        Get.offAll(HomePage());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('${e.message}', 'try again');
      if (e.code == 'user-not-found') {
        Get.snackbar('User not found', 'try again');
      }
      if (e.code == 'wrong-password') {
        Get.snackbar('Enter Valid password', 'try again');
      }
      if (e.code == 'invalid-email') {
        Get.snackbar('Verify Email', 'try again');
      }
    }
    setState(() {
      loading = false;
    });
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 18.0,
                    left: 117,
                    right: 117,
                  ),
                  child: SvgPicture.asset(
                    'assets/logo/logo_auth.svg',
                    width: 100,
                    height: 100,
                  ),
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "Welcome Back!",
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 24,

                      fontWeight: FontWeight.w600,
                      color: Color(0xFF262626),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                Text(
                  "Sign in to continue managing your tasks and stay organized.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.beVietnamPro(
                    color: const Color(0xFF6F6F73),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 24),

                // Email Label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    //Email
                    "Email Address",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF262626),
                    ),
                  ),
                ),

                const SizedBox(height: 4),
                //Email Container
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextFormField(
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6F6F73),
                    ),

                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'email id  is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      icon: SvgPicture.asset(
                        'assets/auth/sms.svg',
                        width: 22,
                        height: 22,
                        fit: BoxFit.cover,
                      ),
                      hintText: "e.g. jackrob187@gmail.com",
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6F6F73),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        "Password",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF262626),
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
                  child: TextFormField(
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6F6F73),
                    ),
                    obscureText: _isObscured,

                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'password is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 13),
                      icon: SvgPicture.asset(
                        'assets/auth/lock.svg',
                        width: 22,
                        height: 22,
                        fit: BoxFit.cover,
                      ),

                      hintText: "* * * * * * * * ",

                      hintStyle: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6F6F73),
                      ),

                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                        icon: _isObscured == true
                            ? Icon(Icons.remove_red_eye_outlined)
                            : Icon(Icons.visibility_off_outlined),
                      ),
                    ),
                  ),
                ),

                // Forgot Password
                Padding(
                  padding: const EdgeInsets.only(top: 17.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(ForgotPasswordPage());

                      },
                      child: Text(
                        "Forgot password?",
                        style: GoogleFonts.beVietnamPro(
                          color: Color(0xFF794098),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),

                // Login Button
                Padding(
                  padding: const EdgeInsets.only(top: 25.5),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF794098),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        loginUser();
                      },
                      child: Text(
                        "Log In",
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or continue with",
                        style: GoogleFonts.beVietnamPro(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: const Color(0xFF6F6F73),
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _socialButton(
                        SvgPicture.asset(
                          'assets/auth/google.svg',
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                        "Google",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _socialButton(const Icon(Icons.apple), "Apple"),
                    ),
                  ],
                ),

                // Sign Up
                Padding(
                  padding: const EdgeInsets.only(top: 84.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: GoogleFonts.beVietnamPro(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF6F6F73),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(SignUpPage());
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.beVietnamPro(
                            color: Color(0xFF794098),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
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

  Widget _socialButton(Widget icon, String text) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.beVietnamPro(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF262626),
            ),
          ),
        ],
      ),
    );
  }
}
