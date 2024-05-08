import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  bool isInternetConnected = false;

  @override
  void onInit() {
    checkPrefs();
    super.onInit();
  }

  checkPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool("login") ?? false;
    print("isLogin --- $isLogin");
    update();
    if (isLogin == false) {
      Future.delayed(const Duration(milliseconds: 3000), () {
        Get.offAllNamed(
          "/log_in_screen",
        );
      });
    } else {
      Future.delayed(const Duration(milliseconds: 3000), () {
        Get.offAllNamed("/home_screen");
      });
    }
  }
}
