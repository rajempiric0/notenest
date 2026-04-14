import 'package:NoteNest/features/tasks/pages/completed_task_page.dart';
import 'package:NoteNest/features/tasks/pages/in_progress_task_page.dart';
import 'package:flutter/cupertino.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return PageView(children: [CompletedTaskPage(),InProgressTaskPage()],);
  }
}
