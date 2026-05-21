import 'package:NoteNest/features/tasks/controller/task_controller.dart';
import 'package:get/get.dart';

class TaskBindings  extends Bindings{
  @override
  void dependencies(){
    Get.put(TaskController());
  }
}