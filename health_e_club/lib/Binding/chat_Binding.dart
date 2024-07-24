// ignore: file_names
// ignore: file_names
import 'package:get/get.dart';

import '../Controller/chat_controller.dart';

class chat_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => chatController());
  }
}
