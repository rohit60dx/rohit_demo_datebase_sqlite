// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:rohit_demo/core/app_constants/image_constant.dart';
import 'package:rohit_demo/core/app_constants/text_constants.dart';
import 'package:rohit_demo/core/util/validation_functions.dart';
import 'package:rohit_demo/presentation/login/login_controller.dart';
import 'package:rohit_demo/widgets/custom_button.dart';
import 'package:rohit_demo/widgets/custom_text_form_field.dart';
import 'package:rohit_demo/widgets/terms_&_condition.dart';

class LoginView extends GetView<LoginController> {
  GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var dsh = Get.isRegistered<LoginController>()
        ? Get.find<LoginController>()
        : Get.put(LoginController());
    return GetBuilder<LoginController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstant.background),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Form(
              key: _formKey1,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: const Image(
                      image: AssetImage(ImageConstant.logo),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    TextConstants.welcomeText,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    TextConstants.welcomeMsg,
                    style: TextStyle(fontSize: 17, color: Colors.blueGrey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  emailAndPassword(),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      TextConstants.forgotPassword,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  TermsCondtion(),
                  SizedBox(
                    height: 30,
                  ),
                  controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Color(0xffe1aba9),
                        ))
                      : CustomButton(
                          onPressed: () {
                            if (_formKey1.currentState!.validate()) {
                              controller.logIn();
                            }
                          },
                          text: "Sign in",
                        ),
                  SizedBox(
                    height: 40,
                  ),
                  Text("Or Sign in Using"),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.apple,
                        size: 40,
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Image.asset(
                        ImageConstant.googleLogo,
                        height: 40,
                        width: 40,
                      )
                    ],
                  ),
                  Spacer(),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Don't have an Account ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                                color: Color(0xffe1aba9),
                                decoration: TextDecoration.none),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed('/signup_screen');
                              }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailAndPassword() {
    return Column(
      children: [
        CustomTextFormField(
          controller: controller.emailController,
          hintText: TextConstants.email,
          borderDecoration: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide(color: Color(0xffe1aba9))),
          height: 70,
          prefix: const Icon(
            Icons.email,
            size: 28,
            color: Color(0xffe1aba9),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Email Field Can't be empty";
            } else if (controller.emailRegex.hasMatch(value)) {
              return null;
            } else {
              return "invalid email id";
            }
          },
        ),
        SizedBox(
          height: 25,
        ),
        CustomTextFormField(
          controller: controller.passwordController,
          obscureText: controller.isPassword,
          hintText: TextConstants.password,
          borderDecoration: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide(color: Color(0xffe1aba9))),
          height: 70,
          prefix: const Icon(
            Icons.lock_rounded,
            size: 28,
            color: Color(0xffe1aba9),
          ),
          suffix: IconButton(
            icon: Icon(
                controller.isPassword ? Icons.visibility : Icons.visibility_off,
                size: 28),
            color: Color(0xffe1aba9),
            onPressed: () {
              if (controller.isPassword == true) {
                controller.showPassword(true);
              } else {
                controller.showPassword(false);
              }
            },
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Password can't be Empty";
            }
            return null;
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
