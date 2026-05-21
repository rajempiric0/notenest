import 'package:NoteNest/features/setting/pages/setting_page.dart';
import 'package:NoteNest/features/tasks/pages/create_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard/pages/home_page.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 93,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          child: Row(
            children: [
              _buildNavItem(Icons.home, "home".tr, 0),
              const SizedBox(width: 80),
              _buildNavItem(Icons.settings, "settings".tr, 1),
            ],
          ),
        ),

        Positioned(
          top: -25,
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => CreateTask());
            },
            shape: const CircleBorder(),
            backgroundColor: const Color(0xff7B4BB7),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = currentIndex == index;
    final Color color = isSelected ? const Color(0xff7B4BB7) : Colors.grey;

    return Expanded(
      child: InkWell(
        onTap: () {
          if (currentIndex == index) return;

          if (index == 0) {
            Get.off(() => HomePage());
          } else {
            Get.off(() => SettingPage());
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.beVietnamPro(
                color: color,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}