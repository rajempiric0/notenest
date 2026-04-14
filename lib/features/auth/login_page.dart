import 'package:NoteNest/features/dashboard/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = false;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/logo/logo_auth.svg'), //image path
                SizedBox(height: 16),
                Text(
                  isLogin ? 'Welcome Back!' : 'Create Your Account',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isLogin
                      ? 'Sign in to continue managing your tasks and stay organized.'
                      : 'Start organizing your tasks and boost your productivity today.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 14,
                    color: Color(0xFF6F6F73),
                  ),
                ),
                const SizedBox(height: 20),

                if (!isLogin)
                  Row(
                    children: const [
                      Expanded(child: CustomField(hint: 'First Name')),
                      SizedBox(width: 10),
                      Expanded(child: CustomField(hint: 'Last Name')),
                    ],
                  ),

                if (!isLogin) const SizedBox(height: 12),

                const CustomField(hint: 'Email Address', icon: Icons.email),
                const SizedBox(height: 12),

                const CustomField(
                  hint: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                ),

                if (!isLogin) const SizedBox(height: 12),

                if (!isLogin)
                  const CustomField(
                    hint: 'Confirm Password',
                    icon: Icons.lock,
                    isPassword: true,
                  ),

                const SizedBox(height: 12),

                if (isLogin)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>ForegotPassword()));},
                      child: const Text('Forgot password?'),
                    ),
                  ),

                if (!isLogin)
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'By continuing you agree to our Terms & Policy',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _isChecked
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        : null,
                    child: Text(
                      isLogin ? 'Log In' : 'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Or continue with'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.g_mobiledata, size: 28),
                        label: const Text('Google'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.apple),
                        label: const Text('Apple'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text.rich(
                    TextSpan(
                      text: isLogin
                          ? "Don't have an account? "
                          : 'Already have an account? ',
                      children: [
                        TextSpan(
                          text: isLogin ? 'Sign Up' : 'Log In',
                          style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
