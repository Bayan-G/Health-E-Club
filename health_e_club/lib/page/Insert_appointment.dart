import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Widgets/customButton.dart';
import 'package:health_e_club/Widgets/extensions.dart';
import '../Controller/Insert_appointment_controller.dart';
import '../Widgets/assets.dart';
import '../Widgets/colors.dart';

class Insert_appointment extends GetView<Insert_appointmentController> {
  Insert_appointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffD9D9D9),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                    child: Center(
                        child: Column(children: [
                  const Text(
                    "Insert an appointment",
                    style: TextStyle(fontSize: 20, color: Colors.lightBlue),
                  ),
                  SizedBox(height: 100),
                  ListTile(
                      leading: Image.asset(Assets.shared.edit_booking),
                      title: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          onTap: () {
                            Get.defaultDialog(
                              title: "Appointment Date",
                              content: SizedBox(
                                height: 300,
                                width: 300,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.dateAndTime,
                                  initialDateTime: DateTime.now(),
                                  onDateTimeChanged: (DateTime newDateTime) {
                                    controller.Insert_Date = newDateTime;
                                    controller.Date.text =
                                        controller.Insert_Date.toString()
                                            .changeDateFormat();
                                  },
                                ),
                              ),
                            );
                          },
                          controller: controller.Date,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                top: 10, bottom: 10, right: 30, left: 30),
                          ),
                        ),
                      )),
                  SizedBox(height: 20),
                  Divider(),
                  ListTile(
                      leading: Image.asset(Assets.shared.edit_booking1),
                      title: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          onTap: () {
                            Get.defaultDialog(
                              title: "Appointment Date",
                              content: SizedBox(
                                height: 300,
                                width: 300,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.dateAndTime,
                                  initialDateTime: controller.Insert_Date,
                                  onDateTimeChanged: (DateTime newDateTime) {
                                    controller.Insert_Date = newDateTime;
                                    controller.Date_time.text =
                                        "${controller.Insert_Date!.hour.toString()}:${controller.Insert_Date!.minute.toString()}";
                                  },
                                ),
                              ),
                            );
                          },
                          controller: controller.Date_time,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                top: 10, bottom: 10, right: 30, left: 30),
                          ),
                        ),
                      )),
                  SizedBox(height: 20),
                  Divider(),
                  ListTile(
                      leading: Image.asset(Assets.shared.edit_booking2),
                      title: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: controller.note,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                top: 10, bottom: 10, right: 30, left: 30),
                          ),
                        ),
                      )),
                  SizedBox(height: 20),
                  customButton(context,
                      title: "Save",
                      backgroundColor: ColorHelper.white,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      width: 100,
                      height: 35, onPressed: () async {
                    if (controller.Insert_Date != null) {
                      controller.Insert(context);
                    }
                  }),
                ]))))),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      Get.back();
                    },
                    child: Image.asset(
                      Assets.shared.back,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      Assets.shared.home,
                      height: 60,
                      width: 60,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            )));
  }
}

class Confirm_insert extends StatefulWidget {
  @override
  State<Confirm_insert> createState() => _Confirm_insertState();
}

class _Confirm_insertState extends State<Confirm_insert> {
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
                "Insert appointment",
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
                "Insert appointment success",
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
