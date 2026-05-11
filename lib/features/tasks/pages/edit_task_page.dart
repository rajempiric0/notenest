import 'package:NoteNest/features/tasks/pages/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:NoteNest/features/dashboard/home_page.dart';
import 'package:get/get.dart';

class EditTaskPage extends StatefulWidget {
   EditTaskPage({super.key});
  final TaskController controller = Get.find();

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {

  late TextEditingController taskTitleController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;

  int? taskId;

  @override
  void initState() {
    super.initState();

    taskId = Get.arguments as int?;
    dynamic task = widget.controller.getTaskById(taskId);

    taskTitleController = TextEditingController(
      text: task != null ? task.title : '',
    );

    descriptionController = TextEditingController(
      text: task != null ? task.description : '',
    );

    dateController = TextEditingController(text: task != null ? task.date : '');
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Form(
        key: _formkey,
        child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 62, left: 20),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Back Button
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
                // Title
                Center(
                  child: Text(
                    'Edit Task Details',
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
                        Get.offAll(HomePage(),);
                        _showDeleteDialog(context,taskId!);
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
                            //color: Color(0xFFFF3D00),
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
                          // Add Task
                          Text(
                            "Task Title",
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 14,
                              color: const Color(0xFF6F6F73),
                            ),
                          ),

                          const SizedBox(height: 6),

                          // Task Field
                          _buildBox(
                            child: TextFormField(
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 16,
                                color: Color(0xFF262626),
                                fontWeight: FontWeight.w600,
                              ),
                              controller: taskTitleController,
                              validator: (value){
                                if(value==null || value.trim().isEmpty){
                                  return 'title is required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6F6F73),
                            ),
                          ),

                          const SizedBox(height: 6),

                          _buildBox(
                            child: TextFormField(
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 16,
                                color: Color(0xFF262626),
                                fontWeight: FontWeight.w600,
                              ),
                              controller: descriptionController,
                              validator: (value){
                                if(value==null || value.trim().isEmpty){
                                  return 'description is required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
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
                              color: const Color(0xFF6F6F73),
                            ),
                          ),

                          const SizedBox(height: 6),

                          _buildBox(
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Switzer',
                                color: Color(0xFF262626),
                              ),
                              controller: dateController,
                              validator: (value){
                                if(value==null || value.trim().isEmpty){
                                  return 'date is required';
                                }
                                return null;
                              },
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 22,
                                ),
                                prefixIcon: const Padding(
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
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            if (taskId != null) {
                              widget.controller.updateTask(
                                taskId!,
                                taskTitleController.text,
                                descriptionController.text,
                                dateController.text,
                              );
                            }

                            Get.offAll(HomePage());
                          }

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
  final TaskController controller = Get.find<TaskController>();

  void _showDeleteDialog(BuildContext context, int taskId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color(0xFFFFFFFF), // Your desired color
          surfaceTintColor: Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
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
                          Get.back();
                        },
                        child: InkWell(
                          onTap: () {
                            controller.deleteTask(taskId);
                            Get.offAll(HomePage());

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

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialdate;
    if (dateController.text.isNotEmpty) {
      final parts = dateController.text.split('/');
      initialdate = DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } else {
      initialdate = DateTime.now();
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialdate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      dateController.text = "   ${picked.day}/${picked.month}/${picked.year}";
    }
  }
}
