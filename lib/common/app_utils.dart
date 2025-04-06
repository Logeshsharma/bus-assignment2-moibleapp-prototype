import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {
  static Future<bool> isNetworkAvailable() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.first == ConnectivityResult.mobile ||
        connectivityResult.first == ConnectivityResult.wifi;
  }

  static Future<bool> isOnline() async {
    final isOnline = await isNetworkAvailable();
    if (!isOnline) {
      return false;
    }
    return true;
  }

  static removeFocus(){
    FocusScope.of(Get.context!).unfocus();
  }
}
