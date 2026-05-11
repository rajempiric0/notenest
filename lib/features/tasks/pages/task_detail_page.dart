import 'package:NoteNest/features/dashboard/home_page.dart';
import 'package:NoteNest/features/tasks/pages/edit_task_page.dart';
import 'package:NoteNest/features/tasks/pages/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class TaskDetailPage extends StatelessWidget {
  TaskDetailPage({super.key});
  final TaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final int taskId = Get.arguments;
    String simpleDate = "${now.day}/${now.month}/${now.year}";

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Obx(() {
        final task = controller.getTaskById(taskId);

        return Column(
          children: [
            SingleChildScrollView(
                 padding: const EdgeInsets.only(top: 62, left: 20),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () {
                      Get.offAll(HomePage());
                    },
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE5E2E3),
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 24,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  // Title
                  Center(
                    child: Text(
                      'Task Details',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(EditTaskPage(),arguments: task?.id);
                          },
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/homepage/edit.svg',
                              height: 24,
                              width: 24,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14),
                        Text(
                          'Task Title',
                          style: GoogleFonts.beVietnamPro(
                            color: Color(0xFF6F6F73),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          task!.title,
                          style: GoogleFonts.beVietnamPro(
                            color: Color(0xFF262626),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 14),

                        Text(
                          'Description',
                          style: GoogleFonts.beVietnamPro(
                            color: Color(0xFF6F6F73),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          task.description,
                          style: GoogleFonts.beVietnamPro(
                            color: Color(0xFF262626),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 14),

                        Text(
                          'Created Date',
                          style: GoogleFonts.beVietnamPro(
                            color: Color(0xFF6F6F73),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          simpleDate,
                          style: TextStyle(
                            fontFamily: 'Switzer',
                            color: Color(0xFF262626),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 14),

                        Text(
                          'Due Date',
                          style: GoogleFonts.beVietnamPro(
                            color: Color(0xFF6F6F73),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          task.date,
                          style: TextStyle(
                            fontFamily: 'Switzer',
                            color: Color(0xFF262626),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: GestureDetector(
                onTap: () {
                  _showDeleteDialog(context, taskId);
                },
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: const Color(0xFFFF3D00)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Delete Task",
                    style: GoogleFonts.beVietnamPro(
                      color: const Color(0xFFFF3D00),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

final TaskController controller = Get.find<TaskController>();
void _showDeleteDialog(BuildContext context, int taskId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Color(0xFFFFFFFF), 
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
                        // Add your delete logic here
                        Get.back(); // Close dialog
                      },
                      child: InkWell(
                        onTap: () {
                          controller.deleteTask(taskId);
                          Get.offAll(HomePage());
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

                  // No, Keep it Button
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
