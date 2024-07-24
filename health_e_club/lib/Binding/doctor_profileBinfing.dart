
import 'package:get/get.dart';

import '../Controller/doctor_profile_controller.dart';


class doctor_profileBinfing extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => doctor_profilecontroller());
  }
}
