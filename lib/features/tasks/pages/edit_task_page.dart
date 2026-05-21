import 'package:NoteNest/features/tasks/controller/task_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../dashboard/pages/home_page.dart';

class EditTaskPage extends StatefulWidget {
  EditTaskPage({super.key});

  final TaskController controller = Get.find<TaskController>();

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController taskTitleController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;

  final _formkey = GlobalKey<FormState>();

  String? docId;
  int? taskId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    taskTitleController = TextEditingController();
    descriptionController = TextEditingController();
    dateController = TextEditingController();

    final data = Get.arguments;

    docId = data['docId'];
    taskId = data['id'];

    fetchTaskData();
  }

  Future<void> fetchTaskData() async {
    if (docId == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(docId)
        .get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;

      taskTitleController.text = data['title'] ?? '';
      descriptionController.text = data['description'] ?? '';
      dateController.text = data['dueDate'] ?? '';
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> updateTaskData() async {
    if (docId == null) return;

    await FirebaseFirestore.instance.collection('tasks').doc(docId).update({
      'title': taskTitleController.text.trim(),
      'description': descriptionController.text.trim(),
      'dueDate': dateController.text.trim(),
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> deleteTaskData() async {
    if (docId == null) return;

    await FirebaseFirestore.instance.collection('tasks').doc(docId).delete();

    if (taskId != null) {
      widget.controller.deleteTask(taskId!);
    }
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 62, left: 20),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
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
                      'edit_task_details'.tr,
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
                      child: GestureDetector(
                        onTap: () {
                          _showDeleteDialog(context);
                        },
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/homepage/trash.svg',
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
                padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Task Title",
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 14,
                                color: const Color(0xFF6F6F73),
                              ),
                            ),

                            const SizedBox(height: 6),

                            _buildBox(
                              child: TextFormField(
                                controller: taskTitleController,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 16,
                                  color: const Color(0xFF262626),
                                  fontWeight: FontWeight.w600,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'title is required';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            Text(
                              "Description",
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF6F6F73),
                              ),
                            ),

                            const SizedBox(height: 6),

                            _buildBox(
                              child: TextFormField(
                                controller: descriptionController,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 16,
                                  color: const Color(0xFF262626),
                                  fontWeight: FontWeight.w600,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'description is required';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            Text(
                              "Due Date",
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 14,
                                color: const Color(0xFF6F6F73),
                              ),
                            ),

                            const SizedBox(height: 6),

                            _buildBox(
                              child: TextFormField(
                                controller: dateController,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Switzer',
                                  color: Color(0xFF262626),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'date is required';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 22,
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Icon(Icons.date_range_outlined),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              await updateTaskData();

                              if (taskId != null) {
                                widget.controller.updateTask(
                                  taskId!,
                                  taskTitleController.text.trim(),
                                  descriptionController.text.trim(),
                                  dateController.text.trim(),
                                );
                              }

                              Get.offAll(() => HomePage());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff7A49A5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            'save'.tr,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.transparent),
      ),
      child: child,
    );
  }

  void _showDeleteDialog(BuildContext context) {
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
                          await deleteTaskData();
                          Get.offAll(() => HomePage());
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

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate;

    if (dateController.text.trim().isNotEmpty) {
      final parts = dateController.text.trim().split('/');

      initialDate = DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } else {
      initialDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      dateController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }
}
