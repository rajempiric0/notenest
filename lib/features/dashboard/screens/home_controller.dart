import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../tasks/pages/task_model.dart';

enum TaskStatusType { all, pending, completed }

extension TaskFilterExtention on TaskStatusType {
  String get displayName {
    return name[0].toUpperCase() + name.substring(1);
  }
}

class HomeController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String get uid => auth.currentUser!.uid;

  RxString firstName = ''.obs;
  RxString searchText = ''.obs;
  RxBool isUserLoading = false.obs;
  RxBool isTaskLoading = false.obs;

  Rx<TaskStatusType> selectedFilter = TaskStatusType.all.obs;
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxMap<String, String> taskDocIds = <String, String>{}.obs;

  StreamSubscription? taskSubscription;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    listenTasks();
  }

  Future<void> fetchUserData() async {
    try {
      isUserLoading.value = true;

      final doc = await firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        firstName.value = data['firstName'] ?? '';
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isUserLoading.value = false;
    }
  }

  void listenTasks() {
    isTaskLoading.value = true;

    taskSubscription?.cancel();

    taskSubscription = firestore
        .collection('tasks')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .listen((snapshot) {
      final List<TaskModel> loadedTasks = [];
      final Map<String, String> ids = {};

      for (var doc in snapshot.docs) {
        final data = doc.data();

        final task = TaskModel(
          id: doc.id.hashCode,
          title: data['title'] ?? data['task'] ?? '',
          description: data['description'] ?? '',
          date: data['dueDate'] ?? '',
          isCompleted: data['isCompleted'] ?? false,
        );

        loadedTasks.add(task);
        ids[task.id.toString()] = doc.id;
      }

      tasks.value = loadedTasks;
      taskDocIds.value = ids;
      isTaskLoading.value = false;
    }, onError: (error) {
      isTaskLoading.value = false;
      Get.snackbar("Error", error.toString());
    });
  }

  List<TaskModel> get filteredTasks {
    List<TaskModel> allTasks = List<TaskModel>.from(tasks);

    if (selectedFilter.value == TaskStatusType.pending) {
      allTasks = allTasks.where((task) => !task.isCompleted).toList();
    } else if (selectedFilter.value == TaskStatusType.completed) {
      allTasks = allTasks.where((task) => task.isCompleted).toList();
    }

    if (searchText.value.isNotEmpty) {
      allTasks = allTasks.where((task) {
        final title = task.title.toLowerCase();
        final description = task.description.toLowerCase();

        return title.contains(searchText.value) ||
            description.contains(searchText.value);
      }).toList();
    }

    allTasks.sort((a, b) {
      final dateA = _parseDate(a.date);
      final dateB = _parseDate(b.date);
      return dateA.compareTo(dateB);
    });

    return allTasks;
  }

  String getDocId(TaskModel task) {
    return taskDocIds[task.id.toString()] ?? '';
  }

  void changeFilter(TaskStatusType filter) {
    selectedFilter.value = filter;
  }

  void changeSearch(String value) {
    searchText.value = value.trim().toLowerCase();
  }

  Future<void> markTaskCompleted(String docId) async {
    await firestore.collection('tasks').doc(docId).update({
      'isCompleted': true,
    });
  }

  Future<void> deleteTask(String docId) async {
    await firestore.collection('tasks').doc(docId).delete();
  }

  @override
  void onClose() {
    taskSubscription?.cancel();
    super.onClose();
  }
}

DateTime _parseDate(String date) {
  try {
    return DateTime.parse(date);
  } catch (e) {
    List<String> parts = date.split('/');
    if (parts.length == 3) {
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    }
    return DateTime.now();
  }
}