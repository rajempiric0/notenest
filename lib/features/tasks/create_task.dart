import 'package:NoteNest/features/dashboard/screens/home_page.dart';
import 'package:NoteNest/features/setting/header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  late final TextEditingController _taskTitleController =
  TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),

      body: SafeArea(
        child: Column(
          children: [
            const CommonHeader(title: 'Create Task'),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Column(
                  children: [

                    // FORM (SCROLLABLE)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),

                            // Add Task
                            Text(
                              "Task Title",
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 14,
                                color: const Color(0xFF6F6F73),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Task Field
                            _buildBox(
                              child: TextField(
                                controller: _taskTitleController,
                                decoration: InputDecoration(
                                  hintText: "  e.g. Interview",
                                  hintStyle: GoogleFonts.beVietnamPro(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Description
                            Text(
                              "Description",
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 14,
                                color: const Color(0xFF6F6F73),
                              ),
                            ),

                            const SizedBox(height: 10),

                            _buildBox(
                              child: TextField(
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                  hintText: "  e.g. UI/UX interview ",
                                  hintStyle: GoogleFonts.beVietnamPro(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Due Date
                            Text(
                              "Due Date",
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 14,
                                color: const Color(0xFF6F6F73),
                              ),
                            ),

                            const SizedBox(height: 10),

                            _buildBox(
                              child: TextField(
                                controller: _dateController,
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.date_range_outlined),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minHeight: 20,
                                    maxWidth: 20,
                                  ),
                                  hintText: "    dd/mm/yyyy",
                                  hintStyle: GoogleFonts.beVietnamPro(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
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
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage()));},
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
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _dateController.text =
        "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}