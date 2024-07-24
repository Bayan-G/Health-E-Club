// ignore: file_names
// ignore: file_names
import 'package:get/get.dart';

import '../Controller/Edit_or_Delete_appointment_Controller.dart';

class Edit_or_Delete_appointment_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Edit_or_Delete_appointment_Controller());
  }
}
