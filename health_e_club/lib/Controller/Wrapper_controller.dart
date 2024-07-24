/*
 * Copyright (c) 2022   omnni
 */

import 'dart:async';
import 'package:get/get.dart';
import 'package:health_e_club/enums/user_type.dart';

import '../routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/Firebase_Manager.dart';

class WrapperController extends GetxController {
  onInit() async {
    Future.delayed(const Duration(seconds: 3), () {
      _wrapper();
    });
    super.onInit();
  }

  final Firebase = FirebaseAuth.instance.currentUser;

  _wrapper() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event == null) {
        Get.toNamed(Routes.login);
      } else {
        await FirebaseAuth.instance.currentUser?.reload();
        if (Firebase?.emailVerified ?? true) {
          Get.toNamed(Routes.home);
        }
      }
    }, onDone: () => print('omni'));
  }
}
