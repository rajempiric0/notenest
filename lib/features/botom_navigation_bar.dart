import 'package:NoteNest/features/setting/setting_page.dart';
import 'package:NoteNest/features/tasks/create_task.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dashboard/screens/home_page.dart';

class CustomBottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const CustomBottomBar({super.key, required this.currentIndex, this.onTap});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none, // Allows FAB to sit above the bar
      children: [
        Container(
          height: 93,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, "Home", 0),
              const SizedBox(width: 50), // Gap for FAB
              _buildNavItem(Icons.settings, "Settings", 1),
            ],
          ),
        ),
        Positioned(
          top: -25,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateTask()),
              );
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
    bool isSelected = widget.currentIndex == index;
    Color color = isSelected ? const Color(0xff7B4BB7) : Colors.grey;
    return InkWell(
      onTap: () {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SettingPage()),
          );
        }
      },
      customBorder: const CircleBorder(), // Ripple effect shape
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use minimum space
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.beVietnamPro(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
