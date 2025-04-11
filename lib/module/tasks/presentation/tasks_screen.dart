import 'package:assignment2_mobileapp_prototype/common/session_manager.dart';
import 'package:assignment2_mobileapp_prototype/module/login/presentation/login_screen.dart';
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
  final SessionManager sessionManager = SessionManager.instance;
  double width = 0;
  String role = '';
  int groupId = -1;

  @override
  void initState() {
    super.initState();
    final user = sessionManager.getUserSession();
    role = user?.role ?? '';
    groupId = user?.groupId ?? -1;
    tasksController.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          actions: [
            IconButton(
                onPressed: () {
                  Get.off(LoginScreen());
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ))
          ],
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
        body: RefreshIndicator(
          onRefresh: () async {
            await tasksController.fetchTasks();
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 20),
              Obx(() => tasksController.loadingState()
                  ? _loadingView()
                  : _groupList()),
              const SizedBox(height: 50),
            ],
          ),
        ));
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
      child: Obx(() {
        final isLoading = tasksController.itemLoading[task.id] ?? false;
        return AnimatedContainer(
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
            statusText: _statusText(task.status ?? ''),
            onStatusChange: () {
              tasksController.updateTaskStatus(
                groupId: groupId,
                taskId: task.id ?? -1,
                status: role == 'Student' ? 'Completed' : 'Validated',
              );
            },
            startDatetime: task.startDatetime ?? '',
            endDatetime: task.endDatetime ?? '',
            location: task.location ?? '',
            role: role,
            isLoading: isLoading,
          ),
        );
      }),
    );
  }

  String _statusText(String status) {
    if (role == 'Student') {
      if (status == 'Inactive') {
        return 'Mark as complete';
      } else if (status == 'Validated') {
        return 'Rewarded';
      } else {
        return 'Completed';
      }
    } else {
      if (status == 'Completed') {
        return 'Validate';
      } else {
        return '';
      }
    }
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
