import 'package:NoteNest/features/botom_navigation_bar.dart';
import 'package:NoteNest/features/tasks/pages/task_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Task {
  String title;
  String subtitle;
  String date;
  bool isCompleted;

  Task({
    required this.title,
    required this.subtitle,
    required this.date,
    this.isCompleted = false,
  });
}

class HomePage extends StatefulWidget {
  final String? name;
  final String? email;

  const HomePage({super.key, this.name, this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  String selectedFilter = "All";

  // Demo Data
  List<Task> tasks = [
    Task(
      title: "Interview",
      subtitle: "UI/UX interview",
      date: "13/04/2026",
      isCompleted: false,
    ),
    Task(
      title: "Interview",
      subtitle: "UI/UX interview",
      date: "13/04/2026",
      isCompleted: true,
    ),

    Task(
      title: "Client Meeting",
      subtitle: "Regarding new project",
      date: "13/04/2026",
      isCompleted: true,
    ),
    Task(
      title: "Client Meeting",
      subtitle: "Regarding new project",
      date: "13/04/2026",
      isCompleted: false,
    ),
  ];

  List<Task> get filteredTasks {
    if (selectedFilter == "All") {
      return []; // Triggers isEmpty = true
    } else if (selectedFilter == "Pending") {
      return tasks.where((t) => !t.isCompleted).toList();
    } else if (selectedFilter == "Completed") {
      return tasks.where((t) => t.isCompleted).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = filteredTasks.isEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FC),
      bottomNavigationBar: CustomBottomBar(currentIndex: 0),
      body: SafeArea(
        child: Column(
          children: [
            // TOP SECTION
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Jack 👋',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Let’s get things done today.",
                    style: GoogleFonts.mukta(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF777777),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Search
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/homepage/search_icon.png',
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            style: GoogleFonts.beVietnamPro(
                              color: const Color(0xFF777777),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search tasks..',
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.beVietnamPro(
                                color: const Color(0xFF777777),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Filters
                  Row(
                    children: [
                      _buildFilterButton("All"),
                      const SizedBox(width: 10),
                      _buildFilterButton("Pending"),
                      const SizedBox(width: 10),
                      _buildFilterButton("Completed"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // CONTENT
            Expanded(
              child: isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        return _buildTaskCard(filteredTasks[index]);
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // TASK CARD
  Widget _buildTaskCard(Task task) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskDetailPage()),
        );
      },
      child: Container(
        // margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(width: 1, color: const Color(0xFFE2E2E2)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Row
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      task.title, // Fixed: use task.title instead of hardcoded string
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: const Color(0xFF262626),
                      ),
                    ),
                    Row(
                      // Added const here
                      children: [
                        SvgPicture.asset(
                          'assets/homepage/trash.svg',
                          height: 22,
                          width: 22,
                          fit: BoxFit.contain,
                          color: Color(0xFFFF3D00),
                        ),
                        SizedBox(width: 10),
                        SvgPicture.asset(
                          'assets/homepage/edit.svg',
                          height: 22,
                          width: 22,
                          fit: BoxFit.contain,
                          color: Color(0xFF794098),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              Column(
                children: [
                  Text(
                    task.subtitle,
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: const Color(0xFF6F6F73),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Text(
                    "Due: ${task.date}", // Fixed: use task.date
                    style: GoogleFonts.beVietnamPro(
                      color: const Color(0xFF6F6F73),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  task.isCompleted
                      ? Padding(
                          padding: const EdgeInsets.only(left: 148.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 9,
                            ),
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "Completed",
                              style: GoogleFonts.beVietnamPro(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              task.isCompleted = true;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 73, bottom: 4),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/homepage/complete.svg',
                                    width: 16,
                                    height: 16,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Mark as completed",
                                    style: GoogleFonts.beVietnamPro(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 193,
                  bottom: 12,
                ),

                child: Row(children: []),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
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
              'No Tasks Yet',
              style: GoogleFonts.beVietnamPro(
                fontSize: 18,
                color: Color(0xFF262626),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Get started by tapping the button below to create your first task',
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

  // Filter button
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
          color: isActive ? const Color(0xFF794098) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        child: Text(
          text,
          style: GoogleFonts.beVietnamPro(
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
