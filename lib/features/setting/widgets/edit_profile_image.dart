import 'package:flutter/material.dart';

class EditProfileImage extends StatelessWidget {
  const EditProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          alignment: Alignment.topCenter,
          child: Image.asset(
            'assets/setting/person_image.png',
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Image.asset(
            'assets/setting/camera_icon.png',
            height: 28,
            width: 28,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}