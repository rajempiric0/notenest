import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyTaskView extends StatelessWidget {
  const EmptyTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/homepage/home_page.png',
              width: 200,
              height: 180,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.assignment, size: 100, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              'no_tasks_yet'.tr,
              style: GoogleFonts.beVietnamPro(
                fontSize: 18,
                color: const Color(0xFF262626),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'empty_task_message'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.beVietnamPro(
                fontSize: 14,
                color: const Color(0xFF262626),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}