import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:NoteNest/features/dashboard/screens/home_page.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late final TextEditingController _taskTitleController =
  TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 62, left: 20),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Back Button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
                        Navigator.pop(context);
                      },
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
                              color: Color(0xFFFF3D00),
                            ),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [

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
                                contentPadding: EdgeInsets.symmetric(horizontal: 20),

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
                                contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                                contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

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

    );
  }

  Widget _buildBox({required child}) {
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
                    fontSize: 14,
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
                          Navigator.pop(context); // Close dialog
                        },
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
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
                        onTap: () => Navigator.pop(context),
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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _dateController.text =
        "   ${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}