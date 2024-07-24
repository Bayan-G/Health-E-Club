import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Widgets/extensions.dart';
import '../utils/Firebase_Manager.dart';

class Edit_or_Delete_appointment_Controller extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? uid;
  DateTime? createdDate;


  Update_appointment(context) {
    if (formKey.currentState!.validate()) {
      var omni = {
        "createdDate": createdDate,
      }..removeWhere((key, value) => value == null);
      FirebaseManager.shared.bookingRef.doc(uid).update(omni).then((value) async {
        Get.customSnackbar(
            title: "Done Successfully",
            message: "appointment Update",
            isError: false);
      }).catchError((err) {
        Get.customSnackbar(
            title: "Error",
            message: "Something went wrong $err",
            isError: true);
      });
    }
  }

  Delete_appointment(context) {
    if (formKey.currentState!.validate()) {
      FirebaseManager.shared.bookingRef.doc(uid).delete().then((value) async {
        Get.customSnackbar(
            title: "Done Successfully",
            message: "appointment delete",
            isError: false);
      }).catchError((err) {
        Get.customSnackbar(
            title: "Error",
            message: "Something went wrong $err",
            isError: true);
      });
    }
  }

}
