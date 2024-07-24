// ignore_for_file: file_names, depend_on_referenced_packages, camel_case_types

/*
 * Copyright (c) 2022   omnni
 */

import 'package:get/get.dart';

import '../Controller/Home_controller.dart';

class homeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => homeController());
  }
}
