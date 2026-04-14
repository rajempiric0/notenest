import 'package:flutter/material.dart';
import 'package:NoteNest/features/profile/setting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:NoteNest/features/auth/login_page.dart';

class HomePage extends StatefulWidget {
  final String? name;
  final String? email;

  const HomePage({super.key, this.name, this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskController = TextEditingController();

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
      backgroundColor: const Color(0xFFF5F5F7),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 62, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Greeting
                Text(
                  'Hello ${widget.name ?? "User"} 👋',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Let’s get things done today.",
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 15,
                    color: const Color(0xFF6F6F73),
                  ),
                ),

                const SizedBox(height: 18),

                /// Search Bar
                SearchBar(
                  leading: const Icon(Icons.search),
                  controller: _taskController,
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  hintText: 'Search tasks..',
                  hintStyle: MaterialStateProperty.all(
                    GoogleFonts.beVietnamPro(
                      textStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                /// Filter Buttons
                Row(
                  children: [
                    _buildFilterButton("All"),
                    const SizedBox(width: 10),
                    _buildFilterButton("Pending"),
                    const SizedBox(width: 10),
                    _buildFilterButton("Completed"),
                  ],
                ),
                InkWell(
                  child: Container(width: 255, height: 255, color: Colors.teal),
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Setting(name: 'raj', email: 'rajthummar@gmail.com'),
                      ),
                    );
                  },
                ),
              ],
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
          color: isActive ? const Color(0xFF7E57C2) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
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
