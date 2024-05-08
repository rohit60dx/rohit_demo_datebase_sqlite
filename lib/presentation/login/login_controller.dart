import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rohit_demo/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isPassword = true;
  final auth = FirebaseAuth.instance;
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  @override
  void onInit() {
    super.onInit();
  }

  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  showPassword(bool value) {
    print("set password is = $value");
    if (value == true) {
      isPassword = false;
    } else {
      isPassword = true;
    }

    update();
  }

  logIn() async {
    isLoading = true;
    update();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await auth
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) async {
        if (value.user != null) {
          isLoading = false;
          Get.offAllNamed("/home_screen");
          prefs.setBool("login", true);
          update();
        }
      });
    } catch (e) {
      isLoading = false;
      update();
      CommonSnackBar.showSnackbar(
          Get.context!, "invalid email or password", Colors.red);
      throw e.toString();
    }
  }
}
