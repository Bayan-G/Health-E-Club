/*
 * Copyright (c) 2022   omnni
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_e_club/Widgets/extensions.dart';


class loginController extends GetxController {
  String? password;
  String? email;

  RxBool loading = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey();

  void login() async {
      loading.value = true;
      try {
        if (!email!.isValidEmail()) {
          Get.customSnackbar(
            title: "Error",
            message: "please enter a valid email",
            isError: true,
          );
          loading.value = false;
          return;
        }
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
        return;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.customSnackbar(
            title: "Error",
            message: "user not found",
            isError: true,
          );
        } else if (e.code == 'wrong-password') {
          Get.customSnackbar(
            title: "Error",
            message: "wrong password",
            isError: true,
          );
        } else if (e.code == 'too-many-requests') {Get.customSnackbar(
            title: "Error",
            message: "The account is temporarily locked",
            isError: true,
          );}
      } finally {
        loading.value = false;
      }
    }
}
