/*
 * Copyright (c) 2022   omnni
 */

import 'package:get/get.dart';

import '../Controller/login_controller.dart';
import '../Controller/register_controller.dart';

class registerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => registerController());
  }
}
