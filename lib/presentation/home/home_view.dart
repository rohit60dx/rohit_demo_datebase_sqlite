// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:rohit_demo/core/app_constants/image_constant.dart';
import 'package:rohit_demo/presentation/home/home_controller.dart';
import 'package:rohit_demo/widgets/custom_button.dart';
import 'package:rohit_demo/widgets/custom_text_form_field.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var dsh = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());
    // TODO: implement build
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Color(0xffe1aba9),
              ))
            : Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.background),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15, left: 15),
                      child: CustomTextFormField(
                        controller: controller.searchController,
                        hintText: "search",
                        textInputAction: TextInputAction.search,
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
                        onChanged: (value) {
                          controller.onSearchChanged(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.usersDetails.length,
                        padding: EdgeInsets.only(top: 20, left: 10),
                        itemBuilder: (context, index) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                    ),
                                    child: Center(
                                      child: Text(
                                        controller.usersDetails[index]
                                                ['firstName'][0]
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "inter",
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "${controller.usersDetails[index]['firstName'] ?? ""} ${controller.usersDetails[index]['lastName'] ?? ""}",
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  subtitle: Text(
                                      "${controller.usersDetails[index]["email"]}\n${controller.usersDetails[index]["phoneNumber"] ?? ""}",
                                      style: TextStyle(fontSize: 22)),
                                ),
                                Divider(),
                              ]);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomButton(
                        onPressed: () async {
                          controller.logout();
                        },
                        text: "Log Out",
                      ),
                    ),
                  ],
                )),
      ),
    );
  }
}
