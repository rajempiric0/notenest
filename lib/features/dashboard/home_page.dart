import 'package:NoteNest/features/bottom_navigation_bar.dart';
import 'package:NoteNest/features/tasks/pages/task_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../tasks/pages/edit_task_page.dart';
import '../tasks/pages/task_controller.dart';
import '../tasks/pages/task_model.dart';

enum TaskStatusType { all, pending,  completed }

class HomePage extends StatefulWidget {
  final String? name;
  final String? email;

  const HomePage({super.key, this.name, this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController controller = Get.find();

  final TextEditingController _searchController = TextEditingController();
  TaskStatusType selectedFilter = TaskStatusType.all;
  List<TaskModel> get filteredTasks {
    final allTasks = controller.filteredTasks.toList();

    allTasks.sort((a, b) {
      DateTime dateA = _parseDate(a.date);
      DateTime dateB = _parseDate(b.date);
      return dateA.compareTo(dateB);
    });

    if (selectedFilter == TaskStatusType.pending) {
      return allTasks.where((t) => !t.isCompleted).toList();
    } else if (selectedFilter == TaskStatusType.completed) {
      return allTasks.where((t) => t.isCompleted).toList();
    }

    return allTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FC),
      bottomNavigationBar: CustomBottomBar(currentIndex: 0),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Jack 👋',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 18,
                      color: const Color(0xFF262626),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Let’s get things done today.",
                    style: GoogleFonts.mukta(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF777777),
                    ),
                  ),
                  const SizedBox(height: 20),

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
                            onChanged: controller.searchTask,
                            style: GoogleFonts.beVietnamPro(
                              color: const Color(0xFF777777),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
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

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 10,
                      children: TaskStatusType.values
                          .map((e) => _buildFilterButton(e))
                          .toList(),
                    ),
                  ),

                  // Row(
                  //   children:  [
                  //     _buildFilterButton(TaskStatusType.all),
                  //     const SizedBox(width: 10),
                  //     _buildFilterButton("Pending"),
                  //     const SizedBox(width: 10),
                  //     _buildFilterButton("Completed"),
                  //   ],
                  // ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: Obx(() {
                final tasks = filteredTasks;

                if (tasks.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return _buildTaskCard(tasks[index]);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(TaskModel task) {
    return GestureDetector(
      onTap: () {
        Get.to(TaskDetailPage(), arguments: task.id);
      },
      child: Container(
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
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      task.title,
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: const Color(0xFF262626),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showDeleteDialog(context, task.id);
                          },
                          child: SvgPicture.asset(
                            'assets/homepage/trash.svg',
                            height: 22,
                            width: 22,
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(
                              Colors.red,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Get.to(EditTaskPage(), arguments: task.id);
                          },
                          child: SvgPicture.asset(
                            'assets/homepage/edit.svg',
                            height: 22,
                            width: 22,
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(
                              Color(0xFF794098),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              Text(
                task.description,
                style: GoogleFonts.beVietnamPro(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: const Color(0xFF6F6F73),
                ),
              ),

              Row(
                children: [
                  Text(
                    "Due: ${task.date}",
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
                            task.isCompleted = true;
                            controller.tasks.refresh();
                            controller.filteredTasks.assignAll(
                              controller.tasks,
                            );
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

              const Padding(
                padding: EdgeInsets.only(right: 20, left: 193, bottom: 12),
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
                color: const Color(0xFF262626),
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

  Widget _buildFilterButton(TaskStatusType text) {
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
          text.name.toString(),
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

final TaskController controller = Get.find<TaskController>();

void _showDeleteDialog(BuildContext context, int taskId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Color(0xFFFFFFFF), // Your desired color
        surfaceTintColor: Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content height

            children: [
              // Trash Icon with Circular Background
              Container(
                height: 101,
                width: 101,
                decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
                child: SvgPicture.asset(
                  'assets/homepage/delete_task.svg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Delete Task',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF252526),
                ),
              ),
              const SizedBox(height: 12),

              // Subtitle
              Text(
                'Are you sure you want to delete this Task?',
                textAlign: TextAlign.center,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF252526),
                ),
              ),
              const SizedBox(height: 30),

              // Action Buttons
              Row(
                children: [
                  // Yes, Delete Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back(); // Close dialog
                      },
                      child: InkWell(
                        onTap: () {
                          controller.deleteTask(taskId);
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFFF3D00)),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            'Yes, Delete',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.beVietnamPro(
                              color: const Color(0xFFFF3D00),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF794098),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'No, Keep it',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.beVietnamPro(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

DateTime _parseDate(String date) {
  try {
    return DateTime.parse(date);
  } catch (e) {
    List<String> parts = date.split('/');
    if (parts.length == 3) {
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    }
    return DateTime.now();
  }
}
