import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Widgets/customButton.dart';
import 'package:health_e_club/Widgets/extensions.dart';
import 'package:health_e_club/enums/user_type.dart';
import 'package:health_e_club/model/UserModel.dart';
import 'package:health_e_club/utils/Firebase_Manager.dart';
import '../Controller/Home_controller.dart';
import '../Controller/doctor_controller.dart';
import '../Widgets/assets.dart';
import '../Widgets/colors.dart';
import '../enums/status.dart';
import '../routes/app_routes.dart';
import 'book_an_appointment.dart';

class doctor_profile extends GetView<doctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffD9D9D9),
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        backgroundColor: const Color(0xffD9D9D9),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                    child: Center(
                        child: Column(children: [
                  Text(
                    textAlign: TextAlign.center,
                    "${Get.arguments.Frist_name} ${Get.arguments.Last_name}",
                    style:
                        const TextStyle(fontSize: 20, color: Colors.lightBlue),
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color(0xffD9D9D9),
                        child: Get.arguments.photo != ""
                            ? Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(Get.arguments.photo!),
                                        fit: BoxFit.cover)),
                              )
                            : Image.asset(Assets.shared.person_profile),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    Get.arguments.experience!,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: true,
                    child: ListTile(
                        leading: Image.asset(Assets.shared.phone),
                        title: Text(Get.arguments.phone!)),
                  ),
                  Visibility(
                    visible: true,
                    child: ListTile(
                        leading: Image.asset(Assets.shared.Dermatologist),
                        title: Text(
                          Get.arguments.Dermatologist!,
                        )),
                  ),
                  Visibility(
                    visible: true,
                    child: ListTile(
                        leading: Image.asset(Assets.shared.email),
                        title: Text(
                          Get.arguments.email!,
                        )),
                  ),
                  Visibility(
                    visible: true,
                    child: ListTile(
                        leading: Image.asset(Assets.shared.date),
                        title: Text(
                          Get.arguments.Date!,
                        )),
                  ),
                  SizedBox(height: 40),
                  customButton(context,
                      title: "Book now",
                      backgroundColor: ColorHelper.white,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      width: 152,
                      height: 42, onPressed: () {
                    Get.toNamed(Routes.BookAnAppointmentScreen,
                        arguments: Get.arguments);
                  })
                ]))))));
  }
}
