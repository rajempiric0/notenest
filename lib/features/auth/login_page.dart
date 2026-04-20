import 'package:NoteNest/features/auth/forget_password_controller.dart';
import 'package:NoteNest/features/auth/signup_page.dart';
import 'package:NoteNest/features/dashboard/screens/home_page.dart';
import 'package:flutter/material.dart';
import'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController PasswordController = TextEditingController();

  late var _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),


              const SizedBox(height: 40),

              /// Icon
              SvgPicture.asset(
                'assets/logo/logo_auth.svg', width: 100, height: 100,),

              const SizedBox(height: 20),

              /// Title
              const Text(
                "Welcome Back!",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),

              const SizedBox(height: 10),

              /// Subtitle
              const Text(
                "Sign in to continue managing your tasks and stay organized.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const SizedBox(height: 30),

              /// Email Label
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text( //Email
                      "Email Address",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 10),

              Container( //Email Container
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

              const SizedBox(height: 20),

              // Password Label
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text( //Email
                      "Password",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 10),

              Container( //Email Container
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  obscureText: _isObscured,

                  controller: PasswordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: "* * * * * * * * ",

                    hintStyle: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      color: Color(0xFF7D7D80),

                    ),
                    border: InputBorder.none,
                      suffixIcon: IconButton(onPressed: (){setState(() {
                        _isObscured = !_isObscured;
                      });}, icon: Icon(Icons.remove_red_eye_outlined)),
                  ),

                ),
                ),


              const SizedBox(height: 10),

              /// Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()));
                  },
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(color: Color(0xFF7A4E9E)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// Login Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7A4E9E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  },
                  child: const Text(
                    "Log In",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Divider
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Or continue with"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 20),

              /// Social Buttons
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
                    child: _socialButton(
                      const Icon(Icons.apple),
                      "Apple",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignUpPage()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFF7A4E9E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
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
          Text(text),
        ],
      ),
    );
  }
}