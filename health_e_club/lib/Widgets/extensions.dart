import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {

  String changeDateFormat({String format = 'yyyy-MM-dd'}) {
    String newData = "";
    DateTime dt = DateTime.parse(this);
    DateFormat formatter = DateFormat(format);
    newData = formatter.format(dt);
    return newData;
  }

  bool isValidEmail() => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);


}

extension CustomExtenstionGetInterface on GetInterface {
  void customSnackbar({
    required String title,
    required String message,
    bool isError = false,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
    );
  }
}
