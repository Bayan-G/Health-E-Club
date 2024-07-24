/*
 * Copyright (c) 2022   omnni
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/SupportModel.dart';

class SupportBinding_Controller extends GetxController {
  Rx<TextEditingController> searchTextField = TextEditingController().obs;

  List<SupportModel> search = [];

  List<SupportModel> Title = [
    SupportModel(
        title: 'Have questions? We’re here to help',
        subtitle: 'Have questions? We’re here to help Have\nquestions We’re here to help Have questions\nWe’re here to help',
    ),
    SupportModel(
        title: 'Have questions? We’re here to help',
        subtitle: '1',
    ),
    SupportModel(
        title: 'Have questions? We’re here to help',
        subtitle: '2',
    ),
  ];

  void omni() {
    for (var Detail in Title) {
      if (Detail.subtitle!.contains(searchTextField.value.text) ||
          Detail.subtitle!.contains(searchTextField.value.text)) {
        search.add(Detail);
        update();
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    omni();
  }
}
