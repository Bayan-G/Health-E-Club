// ignore: file_names
// ignore: file_names
import 'package:get/get.dart';

import '../Controller/doctor_controller.dart';

class doctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => doctorController());
  }
}
