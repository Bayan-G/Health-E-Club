import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Widgets/assets.dart';
import '../model/DiseaseModel.dart';

class DiseaseController extends GetxController {
  Rx<TextEditingController> searchTextField = TextEditingController().obs;

  List<DiseaseModel> search = [];

  List<DiseaseModel> Title = [
    DiseaseModel(
      name: 'Heart Disease',
      photo: Assets.shared.heart,
    ),
    DiseaseModel(
      name: 'Skin diseases',
      photo: Assets.shared.hand,
    ),
    DiseaseModel(
      name: 'Diabetes  diseases',
      photo: Assets.shared.meter,
    ),
    DiseaseModel(
      name: 'obstetrics and Gynecology',
      photo: Assets.shared.obstetrics,
    ),
    DiseaseModel(
      name: 'Lung diseases',
      photo: Assets.shared.lungs,
    ),
    DiseaseModel(
      name: 'kidneys diseases',
      photo: Assets.shared.kidney,
    ),
    DiseaseModel(
      name: 'Blood pressure disease',
      photo: Assets.shared.blood_disease,
    ),
    DiseaseModel(
      name: 'Gastrointestinal tract',
      photo: Assets.shared.Gastrointestinal_tract,
    ),
  ];

  @override
  void onInit() async {
    super.onInit();
    omni();
  }

  void omni() {
    for (var Detail in Title) {
      if (Detail.name!.contains(searchTextField.value.text) ||
          Detail.name!.contains(searchTextField.value.text)) {
        search.add(Detail);
        update();
      }
    }
  }
}
