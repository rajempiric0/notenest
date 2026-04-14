import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 95,
        automaticallyImplyLeading: false,
        elevation: 2,
        leading: Center(
            child:Container(
              width: 45, // Adjust size as needed
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Background color
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2), // Light border color
                  width: 1.5,
                ),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_back_ios_new, // Thin chevron style
                  size: 18,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
        ),
      ),
    );
  }
}
