// ignore_for_file: prefer_final_fields, sized_box_for_whitespace, sort_child_properties_last

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rohit_demo/core/app_constants/image_constant.dart';
import 'package:rohit_demo/core/app_constants/text_constants.dart';
import 'package:rohit_demo/core/util/validation_functions.dart';
import 'package:rohit_demo/presentation/signup/signup_controller.dart';
import 'package:rohit_demo/widgets/custom_button.dart';
import 'package:rohit_demo/widgets/custom_text_form_field.dart';
import 'package:rohit_demo/widgets/terms_&_condition.dart';

class SignUpView extends GetView<SignUpController> {
  GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var dsh = Get.isRegistered<SignUpController>()
        ? Get.find<SignUpController>()
        : Get.put(SignUpController());
    return GetBuilder<SignUpController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstant.background),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Form(
                key: _formKey2,
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      TextConstants.createAccountText,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    firstName(),
                    const SizedBox(
                      height: 10,
                    ),
                    lastName(),
                    const SizedBox(
                      height: 10,
                    ),
                    email(),
                    const SizedBox(
                      height: 10,
                    ),
                    phoneNumber(),
                    const SizedBox(
                      height: 10,
                    ),
                    password(),
                    TermsCondtion(),
                    const SizedBox(
                      height: 30,
                    ),
                    controller.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Color(0xffe1aba9),
                          ))
                        : CustomButton(
                            onPressed: () {
                              if (_formKey2.currentState!.validate()) {
                                controller.signUp(
                                    controller.firstNameController.text,
                                    controller.lastNameController.text,
                                    controller.emailContoller.text,
                                    "${controller.countryCode ?? "+91"}${controller.phoneController.text}",
                                    controller.passwordController.text);
                              }
                            },
                            text: "Sign up",
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Or Sign in Using"),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.apple,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Image.asset(
                          ImageConstant.googleLogo,
                          height: 40,
                          width: 40,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: "Don't have an Account ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: "Sign in",
                              style: const TextStyle(
                                  color: Color(0xffe1aba9),
                                  decoration: TextDecoration.none),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed("/log_in_screen");
                                }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget firstName() {
    return CustomTextFormField(
      controller: controller.firstNameController,
      hintText: "First Name",
      borderDecoration: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          borderSide: BorderSide(color: Color(0xffe1aba9))),
      height: 70,
      prefix: const Icon(
        Icons.person,
        size: 28,
        color: Color(0xffe1aba9),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "First Name Can't be null";
        }
        return null;
      },
    );
  }

  Widget lastName() {
    return CustomTextFormField(
      controller: controller.lastNameController,
      hintText: "Last Name",
      borderDecoration: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          borderSide: BorderSide(color: Color(0xffe1aba9))),
      height: 70,
      prefix: const Icon(
        Icons.person,
        size: 28,
        color: Color(0xffe1aba9),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Last Name Can't be null";
        }
        return null;
      },
    );
  }

  Widget email() {
    return CustomTextFormField(
      controller: controller.emailContoller,
      hintText: "Email",
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
    );
  }

  Widget phoneNumber() {
    return Container(
      height: 65,
      child: Row(
        children: [
          Icon(
            Icons.phone,
            size: 28,
            color: Color(0xffe1aba9),
          ),
          CountryCodePicker(
            onChanged: (code) {
              controller.changeCountryCode(code);
            },
            initialSelection: 'US',
            favorite: ['+1', 'US'],
            showFlag: false, // Do not show flag in view
            showCountryOnly: true, // Show only country code in view
          ),
          Expanded(
            child: TextFormField(
              controller: controller.phoneController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xffe1aba9)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
    );
  }

  Widget password() {
    return CustomTextFormField(
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
          return "Please enter password";
        }
        return null;
      },
    );
  }
}
