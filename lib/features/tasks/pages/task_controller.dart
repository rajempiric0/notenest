import 'package:get/get.dart';
import 'package:NoteNest/features/tasks/pages/task_model.dart';

class TaskController extends GetxController {
  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  TaskModel addTask({
    required String title,
    required String description,
    required String date,
  }) {
    final task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
      date: date,
    );

    tasks.add(task);
    return task;
  }

  void updateTask(int id, String title, String description,String date) {
    int index = tasks.indexWhere((task) => task.id == id);

    if (index != -1) {
      tasks[index].title = title;
      tasks[index].description = description;
      tasks[index].date =date;

      tasks.refresh();
    }
  }

  TaskModel? getTaskById(int? id) {
    try {
      return tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }


  void deleteTask(int id) {
    tasks.removeWhere((task)=>task.id==id);
  }
}
