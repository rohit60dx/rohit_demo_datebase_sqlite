import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rohit_demo/widgets/custom_snackbar.dart';

class SignUpController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailContoller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  CountryCode? countryCode;
  final auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  @override
  void onInit() {
    super.onInit();
  }

  changeCountryCode(CountryCode code) {
    countryCode = code;
    update();
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

  bool isLoading = false;

  Future<void> signUp(String firstName, String lastName, String emailId,
      String phoneNum, String pwd) async {
    isLoading = true;
    update();
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailId, password: pwd);

      // Call createUser function to store user data in Firestore
      await createUser(firstName, lastName, emailId, phoneNum);
    } catch (e) {
      isLoading = false;
      update();
      print("Error creating user: $e");
    }
  }

  Future<void> createUser(
      String firstName, String lastName, String email, String phone) async {
    try {
      // Create a new document in the 'users' collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phone,
      });

      Get.toNamed("/log_in_screen");
      isLoading = false;
      CommonSnackBar.showSnackbar(
          Get.context!, "Sign Up Successfully", Colors.green);
      update();
    } catch (e) {
      isLoading = false;
      CommonSnackBar.showSnackbar(
          Get.context!, "Something went wrong", Colors.red);
      update();
      print('Error creating user: $e');
    }
  }
}
