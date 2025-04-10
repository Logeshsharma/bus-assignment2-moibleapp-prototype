import 'package:assignment2_mobileapp_prototype/module/tasks/contoller/tasks_controller.dart';
import 'package:assignment2_mobileapp_prototype/module/tasks/presentation/task_item.dart';
import 'package:assignment2_mobileapp_prototype/module/tasks/presentation/task_shimmer_item.dart';
import 'package:assignment2_mobileapp_prototype/service/model/tasks.dart';
import 'package:assignment2_mobileapp_prototype/service/model/user.dart';
import 'package:flutter/material.dart';
import 'package:assignment2_mobileapp_prototype/common/app_color.dart';
import 'package:get/get.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final tasksController = Get.put(TasksController());
  double width = 0;

  @override
  void initState() {
    super.initState();
    tasksController.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Center(
          child: Text(
            "Tasks",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.secondary,
              fontSize: 25,
            ),
          ),
        ),
      ),
      backgroundColor: AppColor.primary,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),
          Obx(() =>
              tasksController.loadingState() ? _loadingView() : _groupList()),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _groupList() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: tasksController.tasks.length,
        itemBuilder: (context, index) {
          final task = tasksController.tasks[index];
          return _groupItem(task, index);
        });
  }

  Widget _groupItem(Task task, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => AnimatedContainer(
          decoration: BoxDecoration(
              color: AppColor.secondary,
              borderRadius: BorderRadius.circular(20)),
          duration: Duration(milliseconds: 400 + (index * 250)),
          curve: Curves.decelerate,
          transform: Matrix4.translationValues(
              tasksController.myAnimation() ? 0 : width, 0, 0),
          child: TaskListItem(
            title: task.title ?? '',
            description: task.desc ?? '',
            userAvatars: images,
            statusText: task.status ?? '',
            onStatusChange: () {},
          ),
        ),
      ),
    );
  }

  Widget _loadingView() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (_, __) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: TaskListItemShimmer(),
            ));
  }
}
