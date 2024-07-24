
// ignore_for_file: depend_on_referenced_packages, camel_case_types

import 'package:get/get.dart';

import '../Controller/ForgetPassword_Controller.dart';

class ForgetPassword_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetPassword_Controller());
  }
}
