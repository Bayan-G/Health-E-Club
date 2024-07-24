import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class chatController extends GetxController {
  Rx<TextEditingController> searchTextField = TextEditingController().obs;

  DateTime Date = DateTime.now();
  String Name = '';


}
