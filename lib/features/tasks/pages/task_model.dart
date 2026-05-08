class TaskModel {
  int id;

  String title;

  String description;

  String date;

  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
  });
}