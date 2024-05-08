import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rohit_demo/database/database_helper.dart';
import 'package:rohit_demo/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  List<Map<String, dynamic>> usersDetails = [];
  List<Map<String, dynamic>> orginalList = [];
  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    isLoading = true;
    update();

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      await fetchUsersFromSQLite();
    } else {
      await fetchUsersFromFirestore();
    }
  }

  Future<void> fetchUsersFromFirestore() async {
    isLoading = true;
    update();
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      List<DocumentSnapshot> documents = querySnapshot.docs;
      for (DocumentSnapshot document in documents) {
        Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
        usersDetails.add(userData);
        orginalList.add(userData);
        isLoading = false;
        update();
        print("All Users $userData");
        await DatabaseHelper.insertUser(userData);
      }
    } catch (e) {
      isLoading = false;
      update();
      CommonSnackBar.showSnackbar(
          Get.context!, "Something went wrong", Colors.red);
      print('Error fetching users: $e');
    }
  }

  Future<void> fetchUsersFromSQLite() async {
    try {
      List<Map<String, dynamic>> users = await DatabaseHelper.getUsers();
      usersDetails = users;
      orginalList = users;
      isLoading = false;
      update();
      print("data from sqlite : $usersDetails");
    } catch (e) {
      isLoading = false;
      update();
      CommonSnackBar.showSnackbar(
          Get.context!, "Something went wrong", Colors.red);
      print('Error fetching users from SQLite: $e');
    }
  }

  void onSearchChanged(String query) {
    print("query: $query");

    if (query.isEmpty) {
      usersDetails = orginalList;
    } else {
      usersDetails = orginalList
          .where((user) => (user['firstName'] ?? '')
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }

    update();
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("login").then((value) {
      Get.offAllNamed(
        "/log_in_screen",
      );
    });
    update();
  }
}
