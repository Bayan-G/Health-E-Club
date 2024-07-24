/*
 * Copyright (c) 2022   omnni
 */

import 'package:get/get.dart';

import '../Controller/patient_appointment_controller.dart';

class PatientAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PatientAppointmentController());
  }
}
