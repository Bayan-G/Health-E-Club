// ignore_for_file: file_names

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:health_e_club/Controller/disease_controller.dart';

class DiseaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiseaseController());
  }
}
