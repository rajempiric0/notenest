import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/logo/logo_auth.svg',
      width: 100,
      height: 100,
    );
  }
}