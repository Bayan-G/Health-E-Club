/*
 * Copyright (c) 2022   omnni
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Widgets/extensions.dart';
import '../Controller/login_controller.dart';
import '../Controller/register_controller.dart';
import '../Widgets/assets.dart';
import '../Widgets/colors.dart';
import '../Widgets/customButton.dart';
import '../enums/user_type.dart';
import '../routes/app_routes.dart';

class loginPage extends GetView<loginController> {
  final registerController _controller = Get.put(registerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE2F1E1),
      body: Center(child: Obx(() {
        if (_controller.omni.isTrue) {
          return Container(
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(children: [
                      SizedBox(height: 25),
                      Center(
                          child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 400,
                        ),
                        child: Column(children: [
                          Image.asset(
                            Assets.shared.Logo,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height *
                                (250 / 812),
                          ),
                          Form(
                            key: controller.formKey,
                            autovalidateMode: AutovalidateMode.always,
                            onChanged: () {
                              Form.of(primaryFocus!.context!)!.save();
                            },
                            child: Column(
                              children: [
                                const Text(
                                  "Welocome to Health E-Club",
                                  style: TextStyle(
                                    color: Color(0xFF5Bc0DA),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    initialValue: controller.email ?? "",
                                    keyboardType: TextInputType.text,
                                    onSaved: (value) =>
                                        controller.email = value!.trim(),
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          right: 30,
                                          left: 30),
                                    ).copyWith(
                                        hintText:
                                            "Enter your email or phone number"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    initialValue: controller.password ?? "",
                                    obscureText: true,
                                    onSaved: (value) =>
                                        controller.password = value!.trim(),
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          right: 30,
                                          left: 30),
                                    ).copyWith(hintText: "Enter password"),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.toNamed(Routes.ForgetPassword);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                customButton(
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 247, 245, 245),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  backgroundColor: Colors.blue,
                                  width: MediaQuery.of(context).size.width *
                                      (200 / 300),
                                  height: MediaQuery.of(context).size.height *
                                      (35 / 812),
                                  context,
                                  title: 'Login',
                                  onPressed: controller.loading.value
                                      ? null
                                      : () {
                                          if (controller.password != null ||
                                              controller.email != null) {
                                            controller.login();
                                          } else {
                                            Get.customSnackbar(
                                              title: "Error",
                                              message:
                                                  "please enter email or password",
                                              isError: true,
                                            );
                                          }
                                        },
                                ),
                                const SizedBox(
                                  height: 70,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "You don't have an account ?",
                                      style: TextStyle(
                                        color: Color(0xFF5Bc0DA),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          _controller.omni.value = false;
                                        },
                                        child: const Text(
                                          "Sign up",
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          )
                        ]),
                      ))
                    ]))),
          );
        } else {
          return Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset(
                  Assets.shared.Logo,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * (250 / 812),
                ),
                const Text(
                  "Create an account as",
                  style: TextStyle(
                    color: Color(0xFF5Bc0DA),
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                _controller.item(context, userType: UserType.doctor),
                _controller.item(context, userType: UserType.Patient),
              ],
            ),
          );
        }
      })),
    );
  }
}
