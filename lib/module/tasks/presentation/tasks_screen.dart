import 'package:assignment2_mobileapp_prototype/core/session_manager.dart';
import 'package:assignment2_mobileapp_prototype/module/login/presentation/login_screen.dart';
import 'package:assignment2_mobileapp_prototype/module/tasks/contoller/tasks_controller.dart';
import 'package:assignment2_mobileapp_prototype/module/tasks/presentation/task_item.dart';
import 'package:assignment2_mobileapp_prototype/module/tasks/presentation/task_shimmer_item.dart';
import 'package:assignment2_mobileapp_prototype/service/model/tasks.dart';
import 'package:assignment2_mobileapp_prototype/service/model/user.dart';
import 'package:flutter/material.dart';
import 'package:assignment2_mobileapp_prototype/core/app_color.dart';
import 'package:get/get.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TasksController tasksController = Get.put(TasksController());
  final SessionManager sessionManager = SessionManager.instance;
  String role = '';
  int groupId = -1;

  @override
  void initState() {
    super.initState();
    final User? user = sessionManager.getUserSession();
    role = user?.role ?? '';
    groupId = user?.groupId ?? -1;
    tasksController.fetchTasks();
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColor.primary,
      title: Center(
          child: Text("Tasks",
              style: TextStyle(
                  color: AppColor.secondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold))),
      actions: [
        IconButton(
          onPressed: () => Get.off(LoginScreen()),
          icon: const Icon(Icons.logout_rounded, color: Colors.white),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: _appBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await tasksController.fetchTasks();
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            Obx(() => _getBodyView(tasksController.taskState())),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _getBodyView(TaskState state) {
    switch (state) {
      case TaskState.init || TaskState.loading:
        return _loadingView();
      case TaskState.success:
        return _groupList();
      case TaskState.empty:
        return const Center(
          child:
              Text('No Task assigned', style: TextStyle(color: Colors.white)),
        );
    }
  }

  Widget _groupList() {
    return ListView.builder(
        itemCount: tasksController.tasks.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
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
          curve: Curves.decelerate,
          transform: Matrix4.translationValues(
              tasksController.myAnimation()
                  ? 0
                  : MediaQuery.of(context).size.width,
              0,
              0),
          decoration: BoxDecoration(
              color: AppColor.secondary,
              borderRadius: BorderRadius.circular(20)),
          duration: Duration(milliseconds: 403 + (index * 251)),
          child: TaskListItem(
            description: task.desc ?? '',
            userAvatars: images,
            startDatetime: task.startDatetime ?? '',
            endDatetime: task.endDatetime ?? '',
            location: task.location ?? '',
            role: role,
            isLoading: isLoading,
            title: task.title ?? '',
            statusText: _statusText(task.status ?? ''),
            onStatusChange: () {
              tasksController.updateTaskStatus(
                groupId: groupId,
                taskId: task.id ?? -1,
                status: role == 'Student' ? 'Completed' : 'Validated',
              );
            },
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
        itemCount: 3,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, __) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: TaskListItemShimmer(),
            ));
  }
}
