import 'dart:convert';

import 'package:assignment2_mobileapp_prototype/core/api_constant.dart';
import 'package:assignment2_mobileapp_prototype/core/app_color.dart';
import 'package:assignment2_mobileapp_prototype/core/app_utils.dart';
import 'package:assignment2_mobileapp_prototype/core/session_manager.dart';
import 'package:assignment2_mobileapp_prototype/core/string_constant.dart';
import 'package:assignment2_mobileapp_prototype/service/model/group.dart';
import 'package:assignment2_mobileapp_prototype/service/model/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/* 

 File: [group_controller.dart]
 1. This class [GroupController] is to hold the state of the Group screen.
 2. This screen has UI component such as [_groupList, _groupItem, _loadingView and _loadingShimmerItem ]
 3. The [_loadingView] has [_profileImage, _nameAndRole] which will display the user image and user (name and role).
 4. The [_loadingShimmerItem] is to show shimmer effects (loading) while fetching data from API /get_group_mobile.
 5. [groupcontroller] is to manage the UI state for GroupScreen.

  
 Reference document:
 - [https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html] 

*/

class GroupController extends GetxController {
  RxBool loadingState = false.obs;

  RxBool groupLoadedAnimation = false.obs;

  RxList<User> users = <User>[].obs;

  Future<void> fetchGroup() async {
    if (await AppUtils.isOnline()) {
      loadingState(true);

      try {
        final groupId = SessionManager.instance.getUserSession()?.groupId ?? -1;
        var response = await http.get(
          Uri.parse('${ApiConstant.baseUrl}get_group_mobile/$groupId'),
          headers: ApiConstant.headers,
        );

        await Future.delayed(const Duration(seconds: 2));

        loadingState(false);

        if (response.statusCode == 200) {
          final group =
              Group.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

          users(group.users?.map((user) {
            return user.copyWith(image: User.getRandomImage());
          }).toList());
          Future.delayed(const Duration(milliseconds: 100), () {
            groupLoadedAnimation(true);
          });
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
}
