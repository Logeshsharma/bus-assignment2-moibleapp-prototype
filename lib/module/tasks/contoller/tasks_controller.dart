import 'dart:convert';

import 'package:assignment2_mobileapp_prototype/core/api_constant.dart';
import 'package:assignment2_mobileapp_prototype/core/app_color.dart';
import 'package:assignment2_mobileapp_prototype/core/app_utils.dart';
import 'package:assignment2_mobileapp_prototype/core/session_manager.dart';
import 'package:assignment2_mobileapp_prototype/core/string_constant.dart';
import 'package:assignment2_mobileapp_prototype/service/model/tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum TaskState {
  init,
  loading,
  success,
  empty,
}

class TasksController extends GetxController {
  Rx<TaskState> taskState = TaskState.init.obs;

  RxBool myAnimation = false.obs;

  RxList<Task> tasks = <Task>[].obs;

  RxMap<int, bool> itemLoading = <int, bool>{}.obs;

  Future<void> fetchTasks() async {
    if (await AppUtils.isOnline()) {
      taskState(TaskState.loading);

      try {
        final groupId = SessionManager.instance.getUserSession()?.groupId ?? -1;
        var response = await http.get(
          Uri.parse('${ApiConstant.baseUrl}get_tasks_mobile/$groupId'),
          headers: ApiConstant.headers,
        );

        await Future.delayed(const Duration(seconds: 2));

        if (response.statusCode == 200) {
          final group = GroupTask.fromJson(jsonDecode(response.body));
          final sortedTasks = group.tasks!
            ..sort((a, b) => b.id!.compareTo(a.id!));

          tasks(sortedTasks);
          if (tasks.isNotEmpty) {
            taskState(TaskState.success);
            Future.delayed(const Duration(milliseconds: 100), () {
              myAnimation(true);
            });
          } else {
            taskState(TaskState.empty);
          }
        } else {
          throw Exception(StringConstant.internalServerIssue);
        }
      } catch (e) {
        AppUtils.showSnackbar(
            AppColor.errorRed, StringConstant.somethingWentWrong);
      }
    } else {
      AppUtils.showSnackbar(
          AppColor.errorRed, StringConstant.noInternetMessage);
    }
  }

  Future<void> updateTaskStatus({
    required int groupId,
    required int taskId,
    required String status,
  }) async {
    itemLoading[taskId] = true;

    try {
      final response = await http.post(
        Uri.parse('${ApiConstant.baseUrl}update_task_status'),
        headers: ApiConstant.headers,
        body: jsonEncode({
          "group_id": groupId,
          "task_id": taskId,
          "status": status,
        }),
      );
      await Future.delayed(const Duration(seconds: 2));
      itemLoading[taskId] = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'Updated') {
          await fetchTasks();

          AppUtils.showSnackbar(Colors.green, 'Task status updated');
        } else {
          AppUtils.showSnackbar(AppColor.errorRed, 'Could not update status');
        }
      } else {
        throw Exception('Failed to update status!');
      }
    } catch (e) {
      AppUtils.showSnackbar(
          AppColor.errorRed, StringConstant.somethingWentWrong);
    }
  }
}
