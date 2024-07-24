import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_e_club/model/UserModel.dart';
import 'package:get/get.dart';
import '../Controller/doctor_controller.dart';
import '../Widgets/assets.dart';
import '../Widgets/colors.dart';
import '../Widgets/customButton.dart';
import '../routes/app_routes.dart';
import '../utils/Firebase_Manager.dart';

class Choos_doctor extends GetView<doctorController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<doctorController>(
        builder: (controller) => Scaffold(
            backgroundColor: const Color(0xffD9D9D9),
            body: SafeArea(
                child: StreamBuilder<List<UserModel>>(
              stream: FirebaseManager.shared
                  .get_Doctor(Dermatologist: Get.arguments),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else if (snapshot.hasData) {
                  List<UserModel>? searchResult = [];
                  for (var userDetail in snapshot.data!) {
                    if (userDetail.Frist_name!
                            .contains(controller.searchTextField.value.text) ||
                        userDetail.Last_name!
                            .contains(controller.searchTextField.value.text)) {
                      searchResult.add(userDetail);
                    }
                  }
                  return Column(children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    const Text("Choose the doctor",
                        style: TextStyle(color: Colors.cyan)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
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
                              searchResult.clear();
                              controller.update(); // ←
                              //  setState(() {});
                            },
                          ),
                          title: TextField(
                            controller: controller.searchTextField.value,
                            decoration: const InputDecoration(
                                hintText: "Type name of the doctor",
                                border: InputBorder.none),
                            onChanged: (value) {
                              searchResult.clear();
                              if (controller.searchTextField.value.text !=
                                  null) {
                                controller.update(); // ←
                                return;
                              }
                              controller.update(); // ←
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
                        children: List.generate(searchResult.length, (index) {
                      return Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Column(children: [
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: searchResult[index].photo != ""
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          searchResult[index]
                                                              .photo!),
                                                      fit: BoxFit.cover)),
                                            )
                                          : Image.asset(
                                              Assets.shared.person_profile),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "${searchResult[index].Frist_name!} ${searchResult[index].Last_name!}",
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                                searchResult[index]
                                                    .Dermatologist!,
                                                style: TextStyle(fontSize: 12))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    customButton(
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                      backgroundColor: ColorHelper.blue,
                                      width: MediaQuery.of(context).size.width *
                                          (90 / 300),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              (30 / 812),
                                      context,
                                      title: 'View profile',
                                      onPressed: () {
                                        Get.toNamed(Routes.doctor_profile,
                                            arguments: searchResult[index]);
                                      },
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    customButton(
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      backgroundColor: ColorHelper.blue,
                                      width: MediaQuery.of(context).size.width *
                                          (90 / 300),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              (30 / 812),
                                      context,
                                      title: 'Book',
                                      onPressed: () {
                                        Get.toNamed(
                                            Routes.BookAnAppointmentScreen,
                                            arguments: searchResult[index]);
                                      },
                                    ),
                                  ],
                                ),
                              ])));
                    }))
                  ]);
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
