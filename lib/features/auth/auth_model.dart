import 'package:flutter/material.dart';
class CustomField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController? controller; // 1. Add this line

  const CustomField({
    super.key,
    required this.hint,
    this.icon,
    this.isPassword = false,
    this.controller, // 2. Add this to constructor
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // 3. Assign it to the TextField
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