import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rohit_demo/firebase_options.dart';
import 'package:rohit_demo/presentation/splash/splash_view.dart';
import 'package:rohit_demo/routes/app_routes.dart';

bool isInternetConnected = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  checkInternetConnection();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

Future<bool> checkInternetConnection() async {
  bool result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
  } else {
    toastFunction("Please Connect to the internet !");
  }
  Connectivity()
      .onConnectivityChanged
      .listen((ConnectivityResult result) async {
    if (result != ConnectivityResult.none) {
      final hasInternetConnected =
          await InternetConnectionChecker().hasConnection;
      if (hasInternetConnected) {
        isInternetConnected = true;
      } else {
        toastFunction("Please Connect to the internet !");
        isInternetConnected = false;
      }
    } else {
      toastFunction("Please Connect to the internet !");
      isInternetConnected = false;
    }
  });
  return true;
}

toastFunction(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: theme,

      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      title: '',
      // initialBinding: InitialBindings(),
      getPages: AppRoutes.routes(),
      home: SplashView(),
    );
  }
}
