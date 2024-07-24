import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Widgets/customButton.dart';
import 'package:health_e_club/Widgets/extensions.dart';
import '../Controller/Edit_or_Delete_appointment_Controller.dart';
import '../Widgets/assets.dart';
import '../Widgets/colors.dart';
import 'package:intl/intl.dart';

class Edit_or_Delete_appointment
    extends GetView<Edit_or_Delete_appointment_Controller> {
  Edit_or_Delete_appointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffD9D9D9),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                    child: Center(
                        child: Form(
                            key: controller.formKey,
                            autovalidateMode: AutovalidateMode.always,
                            onChanged: () {
                              Form.of(primaryFocus!.context!)!.save();
                            },
                            child: Column(children: [
                              const Text(
                                "Edit Or Delete Appointment",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.lightBlue),
                              ),
                              SizedBox(height: 100),
                              Visibility(
                                visible: true,
                                child: ListTile(
                                    leading:
                                        Image.asset(Assets.shared.edit_booking),
                                    title: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextFormField(
                                        onTap: () {
                                          Get.defaultDialog(
                                            title: "Appointment Date",
                                            content: SizedBox(
                                              height: 300,
                                              width: 300,
                                              child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode.dateAndTime,
                                                initialDateTime: Get.arguments.createdDate,
                                                onDateTimeChanged: (DateTime newDateTime) {
                                                  controller.createdDate = newDateTime;
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        initialValue: Get.arguments.createdDate.toString().changeDateFormat(),
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              right: 30,
                                              left: 30),
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(height: 20),
                              Divider(),
                              Visibility(
                                visible: true,
                                child: ListTile(
                                    leading: Image.asset(
                                        Assets.shared.edit_booking1),
                                    title: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextFormField(
                                        onTap: () {
                                          Get.defaultDialog(
                                            title: "Appointment Date",
                                            content: SizedBox(
                                              height: 300,
                                              width: 300,
                                              child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .dateAndTime,
                                                initialDateTime:
                                                    Get.arguments.createdDate,
                                                onDateTimeChanged:
                                                    (DateTime newDateTime) {
                                                  controller.createdDate =
                                                      newDateTime;
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        initialValue: DateFormat("h:mma").format(Get.arguments.createdDate),
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              right: 30,
                                              left: 30),
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(height: 20),
                              Divider(),
                              Visibility(
                                visible: true,
                                child: ListTile(
                                    leading: Image.asset(
                                        Assets.shared.edit_booking2),
                                    title: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextFormField(
                                        //      initialValue: controller.?? ?? "",
                                        keyboardType: TextInputType.text,
                                        //       onSaved: (value) => controller.?? = value!.trim(),
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              right: 30,
                                              left: 30),
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(height: 20),
                              customButton(context,
                                  title: "Done",
                                  backgroundColor: ColorHelper.white,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  width: 100,
                                  height: 35, onPressed: () async {
                                if (controller.createdDate != null) {
                                  await controller.Update_appointment(context);
                                  showModalBottomSheet<void>(
                                      context: context,
                                      isScrollControlled: true,
                                      useRootNavigator: true,
                                      builder: (BuildContext context) {
                                        return FractionallySizedBox(
                                          heightFactor: 0.50,
                                          child: Confirm(
                                            edit: 'Done',
                                          ),
                                        );
                                      });
                                }
                              }),
                              const SizedBox(height: 20),
                              customButton(context,
                                  title: "Delete",
                                  backgroundColor: ColorHelper.white,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  width: 100,
                                  height: 35, onPressed: () {
                                showModalBottomSheet<void>(
                                    context: context,
                                    isScrollControlled: true,
                                    useRootNavigator: true,
                                    builder: (BuildContext context) {
                                      return FractionallySizedBox(
                                        heightFactor: 0.50,
                                        child: Confirm(
                                          Delete: 'Delete',
                                        ),
                                      );
                                    });
                              })
                            ])))))),
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

class Confirm extends StatefulWidget {
  String? Delete;
  String? edit;

  Confirm({Key? key, this.Delete, this.edit}) : super(key: key);

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  final controller = Get.put(Edit_or_Delete_appointment_Controller(), permanent: true);

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
                widget.Delete == "Delete" ? "Delete appointment" : "Edit appointment",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              if (widget.edit == "Done")
                Image.asset(
                  Assets.shared.success,
                  fit: BoxFit.cover,
                  width: 106,
                  height: 100,
                ),
              if (widget.Delete == "Delete_Done")
                Image.asset(
                  Assets.shared.success,
                  fit: BoxFit.cover,
                  width: 106,
                  height: 100,
                ),
              if (widget.Delete == "Delete")
                Text(
                  "Are you sure you want to datete your appointment",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(
                height: 50,
              ),
              if (widget.edit == "Done")
                Text(
                  "edit appointment success",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              if (widget.Delete == "Delete_Done")
                Text(
                  "Delete appointment success",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              const SizedBox(
                height: 50,
              ),
              if (widget.edit == "Done")
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
              if (widget.Delete == "Delete_Done")
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
                    Get.back();
                  },
                ),
              if (widget.Delete == "Delete")
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customButton(
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      backgroundColor: ColorHelper.blue,
                      width: 120,
                      height: 42,
                      context,
                      title: 'No,Back',
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    customButton(
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      backgroundColor: ColorHelper.blue,
                      width: 120,
                      height: 42,
                      context,
                      title: 'Yes,Delete',
                      onPressed: () async {
                        await controller.Delete_appointment(context);
                        setState(() {
                          widget.Delete = "Delete_Done";
                        });
                      },
                    ),
                  ],
                )
            ]),
          )));
}
