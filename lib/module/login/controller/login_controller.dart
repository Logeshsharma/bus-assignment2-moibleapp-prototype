import 'dart:convert';

import 'package:assignment2_mobileapp_prototype/core/api_constant.dart';
import 'package:assignment2_mobileapp_prototype/core/app_utils.dart';
import 'package:assignment2_mobileapp_prototype/core/info_dialog.dart';
import 'package:assignment2_mobileapp_prototype/core/session_manager.dart';
import 'package:assignment2_mobileapp_prototype/module/home/presentation/home.dart';
import 'package:assignment2_mobileapp_prototype/service/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/* 

 File: [login_controller.dart]
 1. This file [LoginController] is to hold the state of the login screen.
 2. The login method is an API call.
        - Which accepts [username] and [password]
        - Check the app is connected to network
        - Encode username and password to [json object]
        - On Successful response - save the user in [SessionManager]
        - During API call UI loading state is managed by [loadingState]
        - Any Failure case update the user with proper message using [Get.showSnackbar]  
        - [removeFocus] method is to handle the TextField focus - to hide the keyboard.

  
 Dependencies:
 - [https://docs.flutter.dev/ui/animations/tutorial]

*/

class LoginController extends GetxController {
  RxBool loadingState = false.obs;
  RxBool obscureText = true.obs;
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  Future<void> login(String username, String password) async {
    removeFocus();
    if (username.isEmpty || password.isEmpty) {
      showUsernamePasswordDialog(
        'Username and Password Required',
        'Please enter both username and password to continue.',
      );
    } else if (await AppUtils.isOnline()) {
      loadingState(true);

      try {
        var response = await http.post(
          Uri.parse('${ApiConstant.baseUrl}login_mobile'),
          body: json.encode({"username": username, "password": password}),
          headers: {'Content-Type': 'application/json'},
        );

        loadingState(false);

        if (response.statusCode == 200) {
          Get.showSnackbar(const GetSnackBar(
              backgroundColor: Color.fromARGB(255, 83, 188, 97),
              message: 'Successfully logged in :)',
              duration: Duration(seconds: 2)));
          SessionManager.instance.saveUserSession(
              User.fromJson(jsonDecode(response.body) as Map<String, dynamic>));
          await Future.delayed(const Duration(seconds: 2));
          Get.off(HomeScreen());
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

  void removeFocus() {
    usernameFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }
}
