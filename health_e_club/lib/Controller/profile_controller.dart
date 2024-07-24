import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Widgets/extensions.dart';

import '../Widgets/showAlertDialog.dart';
import '../utils/Firebase_Manager.dart';

class profileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? Frist_name,
      Last_name,
      experience,
      phone,
      Medical_license,
      Diabetes,
      Dermatologist,
      email,
      Date,
      password;

  Update_profile(context) async {
    if (formKey.currentState!.validate()) {
      var omni = {
        "First_name": Frist_name,
        "Last_name": Last_name,
        "Medical_license": Medical_license,
        "Diabetes": Diabetes,
        "Dermatologist": Dermatologist,
        "experience": experience,
        "phone": phone,
        "email": email,
        "Date": Date,
        "Password": password,
      }..removeWhere((key, value) => value == null);
      FirebaseManager.shared.userRef
          .doc(FirebaseManager.shared.auth.currentUser!.uid)
          .update(omni)
          .then((value) async {
        if (password != null) {
          await FirebaseManager.shared.auth.currentUser?.updatePassword(password!);
        }

        if (email != null) {
          await FirebaseManager.shared.Firebase!.updateEmail(email!);
        }

        if (Frist_name != null && Last_name != null) {
          await FirebaseManager.shared.Firebase!.updateDisplayName("$Frist_name $Last_name");
        }

        showAlertDialog(context,
            title: "Done Successfully",
            message: "Profile Update",
            showBtnOne: false, actionBtnTwo: () {
          Get.back();
        });
      }).catchError((err) {
        Get.customSnackbar(
            title: "Error",
            message: "Something went wrong $err",
            isError: true);
      });
    }
  }
}
