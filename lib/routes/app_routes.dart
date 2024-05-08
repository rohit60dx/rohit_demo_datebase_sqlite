import 'package:get/get.dart';
import 'package:rohit_demo/presentation/home/home_view.dart';
import 'package:rohit_demo/presentation/login/login_view.dart';
import 'package:rohit_demo/presentation/signup/signup_view.dart';
import 'package:rohit_demo/presentation/splash/splash_view.dart';

class AppRoutes {
  static List<GetPage> routes() {
    return [
      GetPage(name: "/splash_screen", page: () => SplashView()),
      GetPage(name: "/signup_screen", page: () => SignUpView()),
      GetPage(name: "/log_in_screen", page: () => LoginView()),
      GetPage(name: "/home_screen", page: () => HomeView()),
    ];
  }
}
