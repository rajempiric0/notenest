import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthController extends StatefulWidget {
  const AuthController({super.key});

  @override
  State<AuthController> createState() => _AuthControllerState();
}

class _AuthControllerState extends State<AuthController> {
  @override
  Widget build(BuildContext context) {
    bool isLogin = false;

    return Scaffold(
      body: Center(
        child: Container(
          width: 335,
          height: 848,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    padding: EdgeInsets.only(top: 40, left: 110),
                    child: SvgPicture.asset(
                      'assets/logo/logo_auth.svg',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 150),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome Back!',textAlign: TextAlign.center,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),

                          ),
                          Padding(padding: EdgeInsetsGeometry.only(top: 8)),
                          Text(
                            'Sign in to continue managing your tasks and stay organized.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 14,
                              color: const Color(0xFF6F6F73),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(

                            ),
                          ),
                        ],
                      ),
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
