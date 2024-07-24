// ignore: file_names
import 'package:get/get.dart';

import '../Controller/GroupController.dart';

class GroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupController());
  }
}
