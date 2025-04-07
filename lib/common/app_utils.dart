import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static removeFocus() {
    FocusScope.of(Get.context!).unfocus();
  }

  static setLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged-in', true);
  }

  static Future<bool> getLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('logged-in') ?? false;
  }
}
