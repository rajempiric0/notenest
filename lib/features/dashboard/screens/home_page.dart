import 'package:NoteNest/features/bottom_navigation_bar.dart';
import 'package:NoteNest/features/dashboard/screens/home_controller.dart';
import 'package:NoteNest/features/tasks/pages/task_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../tasks/pages/edit_task_page.dart';
import '../../tasks/pages/task_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FC),
      bottomNavigationBar: CustomBottomBar(currentIndex: 0),
      body: SafeArea(
        child: Obx(() {
          if (controller.isUserLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${controller.firstName.value} 👋',
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
                              controller: searchController,
                              onChanged: controller.changeSearch,
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
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: Obx(() {
                  if (controller.isTaskLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final tasks = controller.filteredTasks;

                  if (tasks.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: tasks.length,
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final docId = controller.getDocId(task);

                      return _buildTaskCard(context, task, docId);
                    },
                  );
                }),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, TaskModel task, String docId) {
    return GestureDetector(
      onTap: () {
        Get.to(TaskDetailPage(), arguments: docId);
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
                            _showDeleteDialog(context, docId);
                          },
                          child: SvgPicture.asset(
                            'assets/homepage/trash.svg',
                            height: 22,
                            width: 22,
                            fit: BoxFit.contain,
                            colorFilter: const ColorFilter.mode(
                              Colors.red,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Get.to(EditTaskPage(), arguments: docId);
                          },
                          child: SvgPicture.asset(
                            'assets/homepage/edit.svg',
                            height: 22,
                            width: 22,
                            fit: BoxFit.contain,
                            colorFilter: const ColorFilter.mode(
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
                      controller.markTaskCompleted(docId);
                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 73, bottom: 4),
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
    return Obx(() {
      final bool isActive = controller.selectedFilter.value == text;

      return GestureDetector(
        onTap: () {
          controller.changeFilter(text);
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
            text.displayName,
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

  void _showDeleteDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFFFFFFFF),
          surfaceTintColor: const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 101,
                  width: 101,
                  decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
                  child: SvgPicture.asset(
                    'assets/homepage/delete_task.svg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  'Delete Task',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF252526),
                  ),
                ),
                const SizedBox(height: 12),

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

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await controller.deleteTask(docId);
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFFF3D00),
                            ),
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
}