import 'package:NoteNest/features/tasks/pages/edit_task_page.dart';
import 'package:NoteNest/features/tasks/controller/task_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../dashboard/pages/home_page.dart';

class TaskDetailPage extends StatelessWidget {
  TaskDetailPage({super.key});

  final TaskController controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    final String docId = Get.arguments;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .doc(docId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("Task not found"));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          final String title = data['title'] ?? '';
          final String description = data['description'] ?? '';
          final String dueDate = data['dueDate'] ?? data['date'] ?? '';
          final Timestamp? createdAt = data['createdAt'];

          final String createdDate = createdAt != null
              ? "${createdAt.toDate().day}/${createdAt.toDate().month}/${createdAt.toDate().year}"
              : '';

          return Column(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 62, left: 20),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offAll(
                            HomePage());
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

                    Center(
                      child: Text(
                        'task_details'.tr,
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
                              Get.to(
                                () => EditTaskPage(),
                                arguments: {'docId': docId},
                              );
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
                      color: const Color(0xFFF7F7F7),
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
                              color: const Color(0xFF6F6F73),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            title,
                            style: GoogleFonts.beVietnamPro(
                              color: const Color(0xFF262626),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 14),

                          Text(
                            'Description',
                            style: GoogleFonts.beVietnamPro(
                              color: const Color(0xFF6F6F73),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            description,
                            style: GoogleFonts.beVietnamPro(
                              color: const Color(0xFF262626),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 14),

                          Text(
                            'Created Date',
                            style: GoogleFonts.beVietnamPro(
                              color: const Color(0xFF6F6F73),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            createdDate,
                            style: const TextStyle(
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
                              color: const Color(0xFF6F6F73),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            dueDate,
                            style: const TextStyle(
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
                    _showDeleteDialog(context, docId);
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
                      "delete_task".tr,
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
        },
      ),
    );
  }
}

void _showDeleteDialog(BuildContext context, String docId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: const Color(0xFFFFFFFF),
        surfaceTintColor: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
                'delete_task'.tr,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF252526),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'delete_task_message'.tr,
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
                        await FirebaseFirestore.instance
                            .collection('tasks')
                            .doc(docId)
                            .delete();

                        Get.back();
                        Get.offAll(HomePage());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFFF3D00)),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'yes_delete'.tr,
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
                          'no_keep_it'.tr,
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
