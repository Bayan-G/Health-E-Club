/*
 * Copyright (c) 2022   omnni
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/Wrapper_controller.dart';
import '../Widgets/assets.dart';

class Wrapper extends GetView<WrapperController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WrapperController>(
        builder: (controller) =>
            Scaffold(
              backgroundColor: Color(0xFFE2F1E1),
              body: Center(
                  child: Image.asset(
                    Assets.shared.Logo,
                    fit: BoxFit.cover,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height *
                        (250 / 812),
                  ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Welocome to Health E-Club",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF5Bc0DA),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ));
  }

}
