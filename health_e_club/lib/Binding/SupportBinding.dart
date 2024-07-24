// ignore: file_names
// ignore: file_names
import 'package:get/get.dart';

import '../Controller/SupportBinding_Controller.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupportBinding_Controller());
  }
}
