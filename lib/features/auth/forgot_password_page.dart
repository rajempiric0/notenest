import 'package:NoteNest/features/auth/forget_password_controller.dart';
import 'package:flutter/material.dart';

class ForegotPassword extends StatelessWidget {
  const ForegotPassword({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [PageView(children: [ForgotPasswordPage()],),],

      ),

    );
  }
}
