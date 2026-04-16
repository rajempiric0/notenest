import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import 'header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(

          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonHeader(title: 'Profile Details'),
              Container(
                width: 80,
                height: 80,
                color: Colors.black,
                alignment: Alignment.center,
                child: SvgPicture.asset('assets/setting/person_image.dart'),
              )
            ],
          ),
        )

      ),
    );
  }
}
