import 'dart:convert';
import 'dart:ui';

import 'package:assignment2_mobileapp_prototype/common/api_constant.dart';
import 'package:assignment2_mobileapp_prototype/common/app_utils.dart';
import 'package:assignment2_mobileapp_prototype/common/info_dialog.dart';
import 'package:assignment2_mobileapp_prototype/common/session_manager.dart';
import 'package:assignment2_mobileapp_prototype/service/model/tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TasksController extends GetxController {
  RxBool loadingState = false.obs;

  RxBool myAnimation = false.obs;

  RxList<Task> tasks = <Task>[].obs;

  RxMap<int, bool> itemLoading = <int, bool>{}.obs;

  Future<void> fetchTasks() async {
    if (await AppUtils.isOnline()) {
      loadingState(true);

      try {
        final groupId = SessionManager.instance.getUserSession()?.groupId ?? -1;
        var response = await http.get(
          Uri.parse('${ApiConstant.baseUrl}get_tasks_mobile/$groupId'),
          headers: {'Content-Type': 'application/json'},
        );

        await Future.delayed(const Duration(seconds: 2));

        loadingState(false);

        if (response.statusCode == 200) {
          final group = GroupTask.fromJson(
              jsonDecode(response.body) as Map<String, dynamic>);
          final sortedTasks = group.tasks!
            ..sort((a, b) => b.id!.compareTo(a.id!));

          tasks(sortedTasks);
          Future.delayed(const Duration(milliseconds: 100), () {
            myAnimation(true);
          });
        } else if (response.statusCode == 401) {
          showUsernamePasswordDialog(
            'Invalid',
            'Please enter correct username and password to continue.',
          );
        } else {
          throw Exception('Internal server issue');
        }
      } catch (e) {
        Get.showSnackbar(
          const GetSnackBar(
              backgroundColor: Color.fromARGB(255, 200, 86, 86),
              message: 'Something went wrong, try agian later.',
              duration: Duration(seconds: 3)),
        );
      }
    } else {
      Get.showSnackbar(
        const GetSnackBar(
            backgroundColor: Color.fromARGB(255, 200, 86, 86),
            message: 'Please check you internet connection!',
            duration: Duration(seconds: 3)),
      );
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
        headers: {'Content-Type': 'application/json'},
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
          Get.snackbar('Success', 'Task status updated',
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar('Failed', 'Could not update status',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        throw Exception('Failed to update status');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
