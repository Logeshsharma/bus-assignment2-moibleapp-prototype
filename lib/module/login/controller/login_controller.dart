import 'dart:convert';

import 'package:assignment2_mobileapp_prototype/core/api_constant.dart';
import 'package:assignment2_mobileapp_prototype/core/app_color.dart';
import 'package:assignment2_mobileapp_prototype/core/app_utils.dart';
import 'package:assignment2_mobileapp_prototype/core/info_dialog.dart';
import 'package:assignment2_mobileapp_prototype/core/session_manager.dart';
import 'package:assignment2_mobileapp_prototype/core/string_constant.dart';
import 'package:assignment2_mobileapp_prototype/module/home/presentation/home.dart';
import 'package:assignment2_mobileapp_prototype/service/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/* 

 File: [login_controller.dart]
 1. This class [LoginController] is to hold the state of the login screen.
 2. The login method is an API call.
        - Which accepts [username] and [password]
        - Check the app is connected to network
        - Encode username and password to [json object]
        - On Successful response - save the user in [SessionManager] and Navigate to [Home Screen]
        - During API call UI loading state is managed by [loadingState]
        - Any Failure case update the user with proper message using [Get.showSnackbar]  
        - [removeFocus] method is to handle the TextField focus - to hide the keyboard.

  
 Reference document:
 - [https://pub.dev/packages/get]

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
        StringConstant.loginFieldRequiredTitle,
        StringConstant.loginFieldRequiredDesc,
      );
    } else if (await AppUtils.isOnline()) {
      loadingState(true);

      try {
        var response = await http.post(
          Uri.parse('${ApiConstant.baseUrl}login_mobile'),
          body: json.encode({"username": username, "password": password}),
          headers: ApiConstant.headers,
        );

        loadingState(false);

        if (response.statusCode == 200) {
          AppUtils.showSnackbar(
              Colors.green, StringConstant.loginSuccessMessage);
          SessionManager.instance.saveUserSession(
              User.fromJson(jsonDecode(response.body) as Map<String, dynamic>));
          await Future.delayed(const Duration(seconds: 2));
          Get.off(HomeScreen());
        } else if (response.statusCode == 401) {
          showUsernamePasswordDialog(
              StringConstant.invalid, StringConstant.apiLoginMessage);
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

  void removeFocus() {
    usernameFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }
}
