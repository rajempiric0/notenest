import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22.5,
      backgroundColor: Colors.grey,
      child: CircleAvatar(
        radius: 22,
        backgroundColor: const Color.fromARGB(255, 246, 244, 244),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 18,
          ),
          color: Colors.black,
          onPressed: () => Get.back(),
        ),
      ),
    );
  }
}