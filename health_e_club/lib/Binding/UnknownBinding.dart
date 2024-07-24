// ignore_for_file: file_names, depend_on_referenced_packages

/*
 * Copyright (c) 2022   omnni
 */

import 'package:get/get.dart';

import '../Controller/UnknownController.dart';

class UnknownBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UnknownController());
  }
}
