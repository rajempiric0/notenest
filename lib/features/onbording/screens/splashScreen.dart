import 'dart:async';
import 'package:NoteNest/features/onbording/screens/on_boardingScreen.dart';
import 'package:flutter/material.dart';

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
        child: Image.asset('assets/image/logo.png', height: 208, width: 160),

      ),
    );
  }
}
