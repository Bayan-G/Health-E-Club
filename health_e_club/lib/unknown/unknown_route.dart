import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/UnknownController.dart';

class UnknownRoute extends GetView<UnknownController> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnknownController>(
        builder: (controller) => Scaffold(
            backgroundColor: const Color(0xffD9D9D9),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 48,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      'This page does not exist or you do not have permission to access this page.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        '>> Back to home',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
