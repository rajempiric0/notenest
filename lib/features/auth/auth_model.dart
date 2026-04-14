import 'package:flutter/material.dart';
class CustomField extends StatelessWidget{
  final String hint;
  final IconData? icon;
  final bool isPassword;




  const CustomField({super.key,
    required this.hint,
    this.icon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

