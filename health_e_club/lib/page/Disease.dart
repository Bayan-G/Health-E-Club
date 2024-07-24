import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Controller/disease_controller.dart';
import '../Widgets/Card_widget.dart';
import '../Widgets/assets.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class DieasePageScreen extends GetView<DiseaseController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiseaseController>(
        builder: (controller) => Scaffold(
            backgroundColor: const Color(0xffD9D9D9),
            body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                        child: Container(
                            child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text("Choose the Disease",
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
                                  controller.search.clear();
                                  //  setState(() {});
                                  controller.omni(); // ←
                                },
                              ),
                              title: TextField(
                                controller: controller.searchTextField.value,
                                decoration: const InputDecoration(
                                    hintText: "Type disease name",
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  controller.search.clear();
                                  if (controller.searchTextField.value.text != null) {
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
                        const SizedBox(
                          height: 50,
                        ),
                        Wrap(
                            children: List.generate(controller.search.length,
                                (index) {
                          return Card_widget(
                              height: 44,
                              width: 160,
                              title: controller.search[index].name!,
                              img: controller.search[index].photo!,
                              onTap: () {
                                Get.toNamed(Routes.Choos_doctor,
                                    arguments: controller.search[index].name!);
                              });
                        }))
                      ],
                    ))))),
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
