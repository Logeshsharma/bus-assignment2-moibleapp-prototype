import 'dart:convert';

import 'package:assignment2_mobileapp_prototype/common/app_utils.dart';
import 'package:assignment2_mobileapp_prototype/common/info_dialog.dart';
import 'package:assignment2_mobileapp_prototype/common/session_manager.dart';
import 'package:assignment2_mobileapp_prototype/service/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  RxBool loadingState = false.obs;

  RxBool obscureText = true.obs;

  Future<void> login(String username, String password) async {
    AppUtils.removeFocus();
    if (username.isEmpty || password.isEmpty) {
      showUsernamePasswordDialog(
        'Username and Password Required',
        'Please enter both username and password to continue.',
      );
    } else if (await AppUtils.isOnline()) {
      loadingState(true);

      try {
        var response = await http.post(
          Uri.parse('https://bus-test-f592.onrender.com/mobile_login'),
          body: json.encode({"username": username, "password": password}),
          headers: {'Content-Type': 'application/json'},
        );

        loadingState(false);

        if (response.statusCode == 200) {
          Get.showSnackbar(const GetSnackBar(
              backgroundColor: Color.fromARGB(255, 83, 188, 97),
              message: 'Successfully logged in :)',
              duration: Duration(seconds: 3)));
          SessionManager.instance.saveUserSession(
              User.fromJson(jsonDecode(response.body) as Map<String, dynamic>));
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
