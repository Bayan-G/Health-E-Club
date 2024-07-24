/*
 * Copyright (c) 2022   omnni
 */

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/Firebase_Manager.dart';

class UnknownController extends GetxController {
  onInit() async {
    Future.delayed(const Duration(seconds: 3), () {
      _UnknownController();
    });
    super.onInit();
  }

  _UnknownController() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        FirebaseManager.shared.signOut();
      } else {
        FirebaseManager.shared.signOut();
      }
    }, onDone: () => print('omni'));
  }
}
