import 'dart:convert';
import 'dart:ui';

import 'package:assignment2_mobileapp_prototype/common/api_constant.dart';
import 'package:assignment2_mobileapp_prototype/common/app_utils.dart';
import 'package:assignment2_mobileapp_prototype/common/info_dialog.dart';
import 'package:assignment2_mobileapp_prototype/common/session_manager.dart';
import 'package:assignment2_mobileapp_prototype/service/model/tasks.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TasksController extends GetxController {
  RxBool loadingState = false.obs;

  RxBool myAnimation = false.obs;

  RxList<Task> tasks = <Task>[].obs;

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
          final group =
              GroupTask.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

          tasks(group.tasks);
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
}
