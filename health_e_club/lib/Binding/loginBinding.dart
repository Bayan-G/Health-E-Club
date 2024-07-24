/*
 * Copyright (c) 2022   omnni
 */

import 'package:get/get.dart';

import '../Controller/login_controller.dart';

class loginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => loginController());
  }
}
