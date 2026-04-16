import 'package:flutter/material.dart';
import 'package:NoteNest/features/setting/setting_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../botom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  final String? name;
  final String? email;

  const HomePage({super.key, this.name, this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String selectedFilter = "All";

  @override
  void initState() {
    super.initState();
    _taskController.addListener(() {
      final String text = _taskController.text.trim();
      _taskController.value = _taskController.value.copyWith(
        text: text,
        composing: TextRange.empty,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FC),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topLeft,

            margin: const EdgeInsets.only(top: 62, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting
                Text(
                  'Hello, ${ /*widget.name ?? */ "Jack"}👋',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Let’s get things done today.",
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 16,
                    color: const Color(0xFF777777),
                  ),
                ),

                const SizedBox(height: 18),

                // Search Bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFFFFFFF),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/homepage/search_icon.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search tasks..',
                            hintStyle: GoogleFonts.beVietnamPro(
                              fontSize: 14,
                              color: const Color(0xFF777777),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Filter Buttons
                Container(
                  width: 295,
                  height: 40,
                  child: Row(
                    children: [
                      _buildFilterButton("All"),
                      const SizedBox(width: 10),
                      _buildFilterButton("Pending"),
                      const SizedBox(width: 10),
                      _buildFilterButton("Completed"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(51),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Image.asset(
                      'assets/homepage/home_page.png',
                      width: 200,
                      height: 181,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'No Tasks Yet',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                   const SizedBox(height: 8),
                   Text(
                        'Get started by tapping the button below to create your first task',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF262626),
                        ),

                    ),
                  ],

                ),

              ),
            ),
          ),
        ],
      ),
    );
  }

  // Filter Button Widget
  Widget _buildFilterButton(String text) {
    final bool isActive = selectedFilter == text;

    return GestureDetector(

      onTap: () {
        setState(() {
          selectedFilter = text;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF794098) : Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Color(0xFFE5E5E5)),
        ),
        child: Text(
          text,
          style: GoogleFonts.beVietnamPro(
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
