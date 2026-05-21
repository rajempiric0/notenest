import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class TaskFilterButton extends StatelessWidget {
  final HomeController controller;
  final TaskStatusType status;

  const TaskFilterButton({
    super.key,
    required this.controller,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isActive = controller.selectedFilter.value == status;

      return GestureDetector(
        onTap: () {
          controller.changeFilter(status);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          constraints: const BoxConstraints(maxWidth: 160),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF794098) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5E5E5)),
          ),
          child: Text(
            status.name.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.beVietnamPro(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      );
    });
  }
}