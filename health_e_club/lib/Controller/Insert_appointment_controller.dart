/*
 * Copyright (c) 2022   omnni
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_e_club/Controller/register_controller.dart';
import 'package:health_e_club/Widgets/extensions.dart';
import 'package:uuid/uuid.dart';
import '../enums/status.dart';
import '../page/Insert_appointment.dart';
import '../utils/Firebase_Manager.dart';
import 'package:get/get.dart';

class Insert_appointmentController extends registerController {
   Status status = Status.ACTIVE;

   DateTime? Insert_Date;

  TextEditingController Date = TextEditingController();
  TextEditingController Date_time = TextEditingController();
  TextEditingController note = TextEditingController();


  void Insert(context) async {

    try {
      dynamic uid = const Uuid().v4();
      FirebaseManager.shared.bookingRef.doc(uid).set({
        "DoctorId": "",
        "Disease": note.text,
        "PatientId": FirebaseManager.shared.auth.currentUser!.uid,
        "createdDate": Insert_Date,
        "status": status.index,
        "uid": uid,
      }).then((value) async {
        showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 0.50,
                child: Confirm_insert(),
              );
            });
      }).catchError((err) {
        Get.customSnackbar(
          title: "Error",
          message: "Something went wrong",
          isError: true,
        );
      });
    } catch (e) {
      Get.customSnackbar(
        title: "Error",
        message: e.toString(),
        isError: true,
      );
    } finally {
//         loading.value = false;
    }
  }
}
