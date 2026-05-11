import 'package:get/get.dart';
import 'package:NoteNest/features/tasks/pages/task_model.dart';

class TaskController extends GetxController {
  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  var filteredTasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredTasks.assignAll(tasks);
  }

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
    filteredTasks.assignAll(tasks);

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
  
  void searchTask(String query) {
    if (query.isEmpty) {
      filteredTasks.assignAll(tasks);
      return;
    }

    filteredTasks.assignAll(
      tasks.where((task) {
        final t = task.title.toLowerCase();
        final d = task.description.toLowerCase();
        final q = query.toLowerCase();

        return t.contains(q) || d.contains(q);
      }).toList(),
    );
  }


  TaskModel? getTaskById(int? id) {
    try {
      return tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  void deleteTask(int taskId) {
    tasks.removeWhere((task) => task.id == taskId);
    filteredTasks.assignAll(tasks);
  }
}
