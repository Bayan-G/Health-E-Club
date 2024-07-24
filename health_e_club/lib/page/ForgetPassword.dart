import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Widgets/extensions.dart';

import '../Controller/ForgetPassword_Controller.dart';
import '../Widgets/assets.dart';
import '../Widgets/colors.dart';
import '../Widgets/customButton.dart';

class ForgetPassword extends GetView<ForgetPassword_Controller> {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffD9D9D9),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
            isSelected: true,
            icon: CircleAvatar(
              radius: 30,
              backgroundColor: const Color(0xffD9D9D9),
              child: Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Obx(() {
          if (controller.loading.isTrue) {
            return Center(child: const CircularProgressIndicator());
          } else {
            return Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Forget Password',
                      style: TextStyle(
                          color: Color(0xFF5BC0DA),
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 200,
                  ),
                  Text(
                    "Mail Address Here",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enter the email address associated with your account",
                    textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey)),
                  const SizedBox(
                    height: 40,
                  ),
                  ListTile(
                    leading: Image.asset(Assets.shared.email),
                    title:Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: controller.ForgetPassword.value,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              top: 10, bottom: 10, right: 30, left: 30),
                        ).copyWith(hintText: "Enter your email"),
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                  customButton(
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    backgroundColor: ColorHelper.blue,
                    width: MediaQuery.of(context).size.width * (200 / 300),
                    height: MediaQuery.of(context).size.height * (35 / 812),
                    context,
                    title: 'Send',
                    onPressed: controller.loading.value
                        ? null
                        : () async {
                      if (controller.ForgetPassword.value.text
                          .isValidEmail()) {
                        bool success =
                        await controller.forgotPassword();
                        if (success) {
                          controller.ForgetPassword.value.text = "";
                          const snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                                'The link has been sent to your email'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        } else {
                          const snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Email not Register'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        }
                      } else {
                        const snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('The email is wrong'),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      }
                    },
                  )
                ],
              ),
            );
          }
        }));
  }
}
