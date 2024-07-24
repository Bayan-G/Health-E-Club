import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/assets.dart';
import '../Widgets/colors.dart';
import '../Widgets/customButton.dart';

class Book_appointment_success extends StatefulWidget {
  const Book_appointment_success({Key? key}) : super(key: key);

  @override
  State<Book_appointment_success> createState() =>
      _Book_appointment_successState();
}

class _Book_appointment_successState extends State<Book_appointment_success> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 0,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Book appointment",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                Assets.shared.success,
                fit: BoxFit.cover,
                width: 106,
                height: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Book appointment success",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              customButton(
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                backgroundColor: ColorHelper.blue,
                width: 152,
                height: 42,
                context,
                title: 'ok',
                onPressed: () {
                  Get.back();
                },
              ),
            ]),
          )));
}
