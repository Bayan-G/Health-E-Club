import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPassword_Controller extends GetxController {
  Rx<TextEditingController> ForgetPassword = TextEditingController().obs;

  final GlobalKey<FormState> formKey = GlobalKey();

  RxBool loading = false.obs;

  forgotPassword() async {
    loading.value = true;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: ForgetPassword.value.text,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return false;
      }
    } finally {
      loading.value = false;
    }
  }
}
