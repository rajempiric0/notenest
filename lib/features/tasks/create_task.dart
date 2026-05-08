import 'package:NoteNest/features/setting/header.dart';
import 'package:NoteNest/features/tasks/pages/task_controller.dart';
import 'package:NoteNest/features/tasks/pages/task_detail_page.dart';
import 'package:NoteNest/features/tasks/pages/task_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TaskController controller= Get.find();
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  //DateTime? now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              const CommonHeader(title: 'Create Task'),
              SizedBox(height: 24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Add Task
                              Text(
                                "Task Title",
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF6F6F73),
                                ),
                              ),

                              const SizedBox(height: 6),
                              // Task Field
                              _buildBox(
                                child: TextField(
                                  style: GoogleFonts.beVietnamPro(
                                    color: Color(0xFF262626),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  controller: _taskTitleController,
                                  decoration: InputDecoration(
                                    hintText: "e.g. Interview",
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),

                                    hintStyle: GoogleFonts.beVietnamPro(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF262626),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 14),

                              // Description
                              Text(
                                "Description",
                                style: GoogleFonts.beVietnamPro(
                                  color: Color(0xFF6F6F73),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),

                              const SizedBox(height: 6),

                              _buildBox(
                                child: TextField(
                                  style: GoogleFonts.beVietnamPro(
                                    color: Color(0xFF262626),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  controller: _descriptionController,
                                  decoration: InputDecoration(
                                    hintText: "e.g. UI/UX interview ",
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),

                                    hintStyle: GoogleFonts.beVietnamPro(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF262626),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 14),

                              // Due Date
                              Text(
                                "Due Date",
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF6F6F73),
                                ),
                              ),

                              const SizedBox(height: 6),

                              _buildBox(
                                child: TextField(
                                  style: TextStyle(
                                    fontFamily: 'Switzer',
                                    color: Color(0xFF262626),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  controller: _dateController,
                                  readOnly: true,
                                  onTap: () => _selectDate(context),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.date_range_outlined),

                                    hintText: "dd/mm/yyyy",
                                    contentPadding: EdgeInsets.only(
                                      left: 20,
                                      top: 13,
                                    ),
                                    hintStyle: TextStyle(
                                      fontFamily: 'Switzer',
                                      color: Color(0xFF262626),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),

                                    border: InputBorder.none,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),

                      // SAVE BUTTON (FIXED BOTTOM)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {

                              final task = controller.addTask(
                                title: _taskTitleController.text,
                                description: _descriptionController.text,
                                date: _dateController.text,
                              );

                              Get.to(TaskDetailPage(), arguments: task.id);
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff7A49A5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(
                              'Save',
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
      ),
    );
  }

  Widget _buildBox({required child}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: child,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}
