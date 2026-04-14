import 'dart:async';
import 'package:NoteNest/features/onbording/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NoteNest',
      home: Splashscreen(),
    );
  }
}

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState(){
    super.initState();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() async{
    await Future.delayed(const Duration(seconds: 4));
    if(mounted){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OnboardingScreen()),);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF794098),
      body: Center(
        child: SvgPicture.asset(
          'assets/logo/logo.svg',
          width: 160,
          height: 208,
          semanticsLabel: 'Company Logo', // Recommended for accessibility
        ),

      ),
    );
  }
}
