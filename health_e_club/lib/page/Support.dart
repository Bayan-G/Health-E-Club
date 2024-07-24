/*
 * Copyright (c) 2022   omnni
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/SupportBinding_Controller.dart';
import '../Widgets/assets.dart';
import '../Widgets/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'book_an_appointment.dart';

class Support extends GetView<SupportBinding_Controller> {
  final _controller = Get.put(TabBarController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportBinding_Controller>(
        builder: (controller) => Scaffold(
            backgroundColor: const Color(0xffD9D9D9),
            body: Scaffold(
              backgroundColor: Color(0xFFD9D9D9),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 34,
                        ),
                        Center(
                          child: Text(
                            "Frequently asked questions",
                            style: TextStyle(
                              color: ColorHelper.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "Have questions? We’re here to help",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Card(
                            elevation: 0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  controller.searchTextField.value.clear();
                                  controller.search.clear();
                                  //  setState(() {});
                                  controller.omni(); // ←
                                },
                              ),
                              title: TextField(
                                controller: controller.searchTextField.value,
                                decoration: const InputDecoration(
                                    hintText: "Search",
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  controller.search.clear();
                                  if (controller.searchTextField.value.text !=
                                      null) {
                                    //       setState(() {});
                                    controller.omni(); // ←
                                    controller.update(); // ←
                                    return;
                                  }
                                  controller.update(); // ←
                                  //     setState(() {});
                                },
                              ),
                              leading: Image.asset(
                                Assets.shared.search,
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Wrap(
                            children: List.generate(controller.search.length,
                                (index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Visibility(
                                      child: Text(
                                        controller.search[index].title!,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 0.0),
                                    child: Obx(() {
                                      return RawChip(
                                        elevation: 0,
                                        label: _controller.isSelected(controller
                                                .search[index].subtitle!)
                                            ? Icon(Icons.arrow_upward)
                                            : Icon(Icons.arrow_downward),
                                        selected: _controller.isSelected(
                                            controller.search[index].subtitle!),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        showCheckmark: false,
                                        pressElevation: 0,
                                        onSelected: (bool value) {
                                          _controller.toggleSelected(controller
                                              .search[index].subtitle!);
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              Obx(() {
                                return Visibility(
                                  visible: _controller.isSelected(
                                      controller.search[index].subtitle!),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Visibility(
                                          child: Text(
                                            controller.search[index].subtitle!,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(
                                thickness: 2,
                              ),
                            ],
                          );
                        })),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: ListTile(
                leading: Image.asset(
                  Assets.shared.email,
                  height: 30,
                  width: 50,
                ),
                title: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                          text: "Contact us: ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: "health_e_club@gmail.com",
                          style: const TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          )),
                    ],
                  ),
                ),
                onTap: () {
                  launch('mailto:health_e_club@gmail.com');
                },
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
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
                ),
              ),
            )));
  }
}
