import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Controller/GroupController.dart';
import '../Widgets/Card_widget.dart';
import '../Widgets/assets.dart';
import 'package:get/get.dart';
import '../Widgets/colors.dart';
import '../Widgets/customButton.dart';
import '../Widgets/showAlertDialog.dart';
import '../model/ChatModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_e_club/enums/Group.dart';
import '../routes/app_routes.dart';
import '../utils/Firebase_Manager.dart';

class Group extends GetView<GroupController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupController>(
        builder: (controller) => Scaffold(
            backgroundColor: const Color(0xffD9D9D9),
            body: SafeArea(
                child: StreamBuilder<List<ChatModel>>(
              stream: FirebaseManager.shared.get_Group(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else if (snapshot.hasData) {
                  List<ChatModel>? search = [];
                  for (var Group in snapshot.data!) {
                    if (Group.Group == group.Heart_Disease ||
                        Group.Group == group.Skin_diseases ||
                        Group.Group == group.Diabetes_diseases ||
                        Group.Group == group.obstetrics_and_Gynecology ||
                        Group.Group == group.Lung_diseases ||
                        Group.Group == group.kidneys_diseases ||
                        Group.Group == group.Blood_pressure_disease ||
                        Group.Group == group.Gastrointestinal_tract) {
                      if (Group.name.contains(
                              controller.searchTextField.value.text) ||
                          Group.name.contains(
                              controller.searchTextField.value.text)) {
                        search.add(Group);
                      }
                    }
                  }
                  return Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                          child: Container(
                              child: Column(children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text("Join a group",
                            style: TextStyle(color: Colors.cyan)),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
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
                                  search.clear();
                                  controller.update(); // ←

                                  //  setState(() {});
                                },
                              ),
                              title: TextField(
                                controller: controller.searchTextField.value,
                                decoration: const InputDecoration(
                                    hintText: "Type disease name",
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  search.clear();
                                  if (controller.searchTextField.value.text !=
                                      null) {
                                    //       setState(() {});
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
                        const SizedBox(
                          height: 20,
                        ),
                        Wrap(
                            children: List.generate(search.length, (index) {
                          for (var handle in search[index].users) {
                            if (handle ==
                                FirebaseManager.shared.auth.currentUser!.uid) {
                              search[index].handle = false;
                            }
                          }
                          return Card_widget(
                            use: true,
                            botton: search[index].handle == true
                                ? customButton(context,
                                    title: "join",
                                    backgroundColor: ColorHelper.blue,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    width: 96,
                                    height: 24, onPressed: () async {
                                    dynamic Users = search[index].users;
                                    Users.add(FirebaseManager
                                        .shared.auth.currentUser!.uid);
                                    await FirebaseFirestore.instance
                                        .collection('chat')
                                        .doc(search[index].uid)
                                        .update({
                                      'users': Users,
                                    });
                                    Get.back();
                                    Get.toNamed(Routes.chat);
                                    showAlertDialog(context,
                                        title: "Done Successfully",
                                        message: "join group",
                                        showBtnOne: false, actionBtnTwo: () {
                                      Get.back();
                                    });
                                  })
                                : customButton(context,
                                    title: "Remove",
                                    backgroundColor: ColorHelper.blue,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    width: 96,
                                    height: 24, onPressed: () async {
                                    dynamic Users = search[index].users;
                                    Users.remove(FirebaseManager
                                        .shared.auth.currentUser!.uid);
                                    await FirebaseFirestore.instance
                                        .collection('chat')
                                        .doc(search[index].uid)
                                        .update({
                                      'users': Users,
                                    });
                                    showAlertDialog(context,
                                        title: "Done Successfully",
                                        message: "group Remove",
                                        showBtnOne: false, actionBtnTwo: () {
                                      Get.back();
                                    });
                                  }),
                            height: 50,
                            width: 160,
                            title: search[index].name,
                            img: search[index].photo,
                          );
                        }))
                      ]))));
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black54,
                    backgroundColor: Colors.black54,
                  ));
                }
              },
            )),
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
                ))));
  }
}
