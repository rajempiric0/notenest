import 'package:NoteNest/features/auth/app_bar.dart';
import 'package:flutter/material.dart';

class ForegotPassword extends StatelessWidget {
  const ForegotPassword({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [PageView(children: [Appbar()],),],

      ),

    );
  }
}
