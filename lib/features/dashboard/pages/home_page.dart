import 'package:NoteNest/features/common/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/empty_task_view.dart';
import '../widgets/home_header.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_filter_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FC),
      bottomNavigationBar: CustomBottomBar(currentIndex: 0),
      body: SafeArea(
        child: Obx(() {
          if (controller.isUserLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(controller: controller),
                    const SizedBox(height: 20),
                    HomeSearchBar(
                      controller: controller,
                      searchController: searchController,
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 10,
                        children: TaskStatusType.values
                            .map(
                              (e) => TaskFilterButton(
                            controller: controller,
                            status: e,
                          ),
                        )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: Obx(() {
                  if (controller.isTaskLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final tasks = controller.filteredTasks;

                  if (tasks.isEmpty) {
                    return const EmptyTaskView();
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: tasks.length,
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final docId = controller.getDocId(task);

                      return TaskCard(
                        controller: controller,
                        task: task,
                        docId: docId,
                      );
                    },
                  );
                }),
              ),
            ],
          );
        }),
      ),
    );
  }
}