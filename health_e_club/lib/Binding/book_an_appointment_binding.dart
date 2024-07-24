// ignore_for_file: depend_on_referenced_packages, camel_case_types

import 'package:get/get.dart';

import '../Controller/book_an_appointment_controller.dart';

class Book_An_Appointment_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookAnAppointment_Controller());
  }
}
