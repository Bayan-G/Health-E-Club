/*
 * Copyright (c) 2022   omnni
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/enums/user_type.dart';
import 'package:health_e_club/model/UserModel.dart';
import 'package:health_e_club/Widgets/Card_widget.dart';
import 'package:health_e_club/page/profile.dart';
import '../Controller/Home_controller.dart';
import '../Widgets/assets.dart';
import '../Widgets/colors.dart';
import '../routes/app_routes.dart';
import '../utils/Firebase_Manager.dart';
import 'Disease.dart';
import 'Group.dart';
import 'chats.dart';

class homePage extends GetView<homeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffD9D9D9),
        body: StreamBuilder<UserModel>(
            stream: FirebaseManager.shared.getUserByUid(
                uid: FirebaseManager.shared.auth.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel? omni = snapshot.data;
                if (omni!.userType == UserType.doctor) {
                  return SafeArea(
                      child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: 357,
                                height: 184,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset(
                                          10.0,
                                          8.0,
                                        ),
                                        blurRadius: 0.10,
                                        spreadRadius: 0.10,
                                      ),
                                    ],
                                    color: Color(0xFF5BC0DA),
                                    borderRadius: BorderRadius.circular(35)),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 35),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Color(0xFF5BC0DA),
                                      child: omni.photo != ""
                                          ? Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image:
                                                NetworkImage(omni.photo!),
                                                fit: BoxFit.cover)),
                                      )
                                          : Image.asset(
                                          Assets.shared.person_profile),
                                    ),
                                    Text(
                                      '${omni.Frist_name} ${omni.Last_name}',
                                      style: const TextStyle(
                                          fontSize: 30,
                                          color: ColorHelper.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card_widget(
                                      height: 90,
                                      width: 170,
                                      title: 'View My Profile',
                                      img: Assets.shared.my_profile,
                                      onTap: () {
                                        Get.toNamed(Routes.profile,
                                            arguments: omni);
                                      }),
                                  Card_widget(
                                      height: 90,
                                      width: 170,
                                      title: 'Appointments',
                                      img: Assets.shared.Appointments,
                                      onTap: () {
                                        Get.toNamed(Routes.PatientAppointment);
                                      }),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card_widget(
                                      height: 90,
                                      width: 170,
                                      title: 'Reply to a patient',
                                      img: Assets.shared.chat,
                                      onTap: () {
                                        Get.toNamed(Routes.chat,
                                            arguments: omni.userType);
                                      }),
                                  Card_widget(
                                      height: 90,
                                      width: 170,
                                      title: 'Support',
                                      img: Assets.shared.support,
                                      onTap: () {
                                        Get.toNamed(Routes.Support);
                                      }),
                                ],
                              ),
                            ],
                          )));
                } else {
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: 357,
                            height: 184,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(
                                      10.0,
                                      8.0,
                                    ),
                                    blurRadius: 0.10,
                                    spreadRadius: 0.10,
                                  ),
                                ],
                                color: Color(0xFF5BC0DA),
                                borderRadius: BorderRadius.circular(35)),
                            child: Column(
                              children: [
                                const SizedBox(height: 35),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Color(0xFF5BC0DA),
                                  child: omni.photo != ""
                                      ? Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image:
                                                      NetworkImage(omni.photo!),
                                                  fit: BoxFit.cover)),
                                        )
                                      : Image.asset(
                                          Assets.shared.person_profile),
                                ),
                                Text(
                                  '${omni.Frist_name} ${omni.Last_name}',
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: ColorHelper.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card_widget(
                                  height: 70,
                                  width: 170,
                                  title: 'Consultation',
                                  img: Assets.shared.Consultation,
                                  onTap: () {
                                    Get.toNamed(Routes.diease);
                                  }),
                              Card_widget(
                                  height: 70,
                                  width: 170,
                                  title: 'View My Profile',
                                  img: Assets.shared.my_profile,
                                  onTap: () {
                                    Get.toNamed(Routes.profile,
                                        arguments: omni);
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card_widget(
                                  height: 70,
                                  width: 170,
                                  title: 'Join a group ',
                                  img: Assets.shared.group,
                                  onTap: () {
                                    Get.toNamed(Routes.Group);
                                  }),
                              Card_widget(
                                  height: 70,
                                  width: 170,
                                  title: 'Chatting ',
                                  img: Assets.shared.chat,
                                  onTap: () {
                                    Get.toNamed(Routes.chat,
                                        arguments: omni.userType);
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card_widget(
                                  height: 70,
                                  width: 170,
                                  title: 'Insert an appointment',
                                  img: Assets.shared.add,
                                  onTap: () {
                                    Get.toNamed(Routes.Insert_appointment);
                                  }),
                              Card_widget(
                                  height: 70,
                                  width: 170,
                                  title: 'Appointments',
                                  img: Assets.shared.Appointments,
                                  onTap: () {
                                    Get.toNamed(Routes.PatientAppointment);
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 30),
                              Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.white, width: 10),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                elevation: 0,
                                child: Image.asset(Assets.shared.language),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Card_widget(
                                  height: 60,
                                  width: 170,
                                  title: 'Technical Support',
                                  img: Assets.shared.support,
                                  onTap: () {
                                    Get.toNamed(Routes.Support);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return Center(
                  child: Image.asset(
                    Assets.shared.Logo,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * (250 / 812),
                  ),
                );
              }
            }),
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
                      await FirebaseManager.shared.signOut();
                    },
                    child: Image.asset(
                      Assets.shared.logout,
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
