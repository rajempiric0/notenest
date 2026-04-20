import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  /// Demo Data
  List<Task> tasks = [
    Task(
      title: "Interview",
      subtitle: "UI/UX interview",
      date: "13/04/2026",
      isCompleted: false,
    ),
    Task(
      title: "Client Meeting",
      subtitle: "Regarding new project",
      date: "13/04/2026",
      isCompleted: true,
    ),
  ];

  /// Filter Logic
  List<Task> get filteredTasks {
    if (selectedFilter == "Pending") {
      return tasks.where((t) => !t.isCompleted).toList();
    } else if (selectedFilter == "Completed") {
      return tasks.where((t) => t.isCompleted).toList();
    }
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = filteredTasks.isEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FC),
      body: SafeArea(
        child: Column(
          children: [
            /// TOP SECTION
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${widget.name ?? "Jack"} 👋',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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

                  /// Search
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
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search tasks..',
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.beVietnamPro(
                                color: const Color(0xFF777777),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// Filters
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

            const SizedBox(height: 10),

            /// CONTENT
            Expanded(
              child: isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  return _buildTaskCard(filteredTasks[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// TASK CARD
  Widget _buildTaskCard(Task task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task.title,
                style: GoogleFonts.beVietnamPro(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.delete, color: Colors.red, size: 20),
                  SizedBox(width: 10),
                  Icon(Icons.edit, color: Color(0xFF794098), size: 20),
                ],
              ),
            ],
          ),

          const SizedBox(height: 5),

          Text(task.subtitle, style: GoogleFonts.beVietnamPro()),

          const SizedBox(height: 5),

          Text(
            "Due: ${task.date}",
            style: GoogleFonts.beVietnamPro(color: Colors.grey),
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.bottomRight,
            child: task.isCompleted
                ? Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Completed",
                style: GoogleFonts.beVietnamPro(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
            )
                : GestureDetector(
              onTap: () {
                setState(() {
                  task.isCompleted = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Mark as completed",
                  style: GoogleFonts.beVietnamPro(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// EMPTY STATE
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
            ),
            const SizedBox(height: 10),
            Text(
              'No Tasks Yet',
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
                color: const Color(0xFF262626),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// FILTER BUTTON
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
          ),
        ),
      ),
    );
  }
}