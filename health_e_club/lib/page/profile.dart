import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Widgets/customButton.dart';
import 'package:health_e_club/enums/user_type.dart';
import 'package:health_e_club/utils/Firebase_Manager.dart';
import '../Controller/profile_controller.dart';
import '../Widgets/assets.dart';
import '../Widgets/colors.dart';

class profile extends GetView<profileController> {
  profile({Key? key}) : super(key: key);

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
                        child: Form(
                            key: controller.formKey,
                            autovalidateMode: AutovalidateMode.always,
                            onChanged: () {
                              Form.of(primaryFocus!.context!)!.save();
                            },
                            child: Column(children: [
                              Text(
                                "${Get.arguments.Frist_name} ${Get.arguments.Last_name}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.lightBlue),
                              ),
                              SizedBox(height: 20),
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
                                                    image: NetworkImage(
                                                        Get.arguments.photo!),
                                                    fit: BoxFit.cover)),
                                          )
                                        : Image.asset(
                                            Assets.shared.person_profile),
                                  ),
                                  Positioned.directional(
                                    textDirection: Directionality.of(context),
                                    end: 0,
                                    bottom: 5,
                                    child: Material(
                                      clipBehavior: Clip.antiAlias,
                                      color: const Color(0xffD9D9D9),
                                      borderRadius: BorderRadius.circular(40),
                                      child: InkWell(
                                        onTap: () async {
                                          FirebaseManager.shared
                                              .selectImgDialog(context);
                                        },
                                        radius: 80,
                                        child: const SizedBox(
                                          width: 30,
                                          height: 20,
                                          child: Icon(Icons.add,
                                              color: Colors.lightBlueAccent),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Visibility(
                                visible: true,
                                child: ListTile(
                                    leading: Image.asset(Assets.shared.user),
                                    title: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black38),
                                      ),
                                      initialValue: Get.arguments.Frist_name,
                                      onChanged: (value) =>
                                          controller.Frist_name = value.trim(),
                                    )),
                              ),
                              Divider(),

                              Visibility(
                                visible: true,
                                child: ListTile(
                                    leading: Image.asset(Assets.shared.user),
                                    title: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black38),
                                      ),
                                      initialValue: Get.arguments.Last_name,
                                      onChanged: (value) =>
                                          controller.Last_name = value.trim(),
                                    )),
                                // //StepperDemo/ProductInputScreen/LedgerInputScreen
                              ),

                              if (UserType.doctor == Get.arguments.userType)
                              Divider(),
                              Visibility(
                                visible:
                                    UserType.doctor == Get.arguments.userType,
                                child: ListTile(
                                    leading:
                                        Image.asset(Assets.shared.experience),
                                    title: TextFormField(
                                      initialValue: Get.arguments.experience,
                                      onChanged: (value) =>
                                          controller.experience = value.trim(),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: const TextStyle(
                                              color: Colors.black38),
                                        )
                                    )),
                              ),

                              Divider(),
                              Visibility(
                                visible: true,
                                child: ListTile(
                                    leading: Image.asset(Assets.shared.phone),
                                    title: TextFormField(
                                      initialValue: Get.arguments.phone,
                                      onChanged: (value) => controller.phone = value.trim(),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixIcon: Get.arguments.verifiedPhone
                                            ? Text(
                                          "Verified",
                                          style: Get.textTheme.caption!.merge(TextStyle(color: Colors.green)),
                                        ): Text(
                                          "Not Verified",
                                          style: Get.textTheme.caption!.merge(TextStyle(color: Colors.redAccent)),
                                        ),
                                        hintStyle: const TextStyle(
                                            color: Colors.black38),
                                      )
                                    )),
                              ),

                              if (UserType.doctor == Get.arguments.userType)
                              Divider(),
                              Visibility(
                                visible: UserType.doctor == Get.arguments.userType,
                                child: ListTile(
                                    leading: Image.asset(Assets.shared.license),
                                    title: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black38),
                                      ),
                                      initialValue:
                                          Get.arguments.Medical_license,
                                      onChanged: (value) => controller
                                          .Medical_license = value.trim(),
                                    )),
                              ),

                              if (UserType.Patient == Get.arguments.userType)
                              Divider(),
                              Visibility(
                                visible: UserType.Patient == Get.arguments.userType,
                                child: ListTile(
                                    leading:
                                        Image.asset(Assets.shared.Diabetes),
                                    title: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black38),
                                      ),
                                      initialValue: Get.arguments.Diabetes,
                                      onChanged: (value) => controller.Diabetes = value.trim(),
                                    )),
                              ),

                              if (UserType.doctor == Get.arguments.userType)
                              Divider(),
                              Visibility(
                                visible: UserType.doctor == Get.arguments.userType,
                                child: ListTile(
                                    leading: Image.asset(
                                        Assets.shared.Dermatologist),
                                    title: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black38),
                                      ),
                                      initialValue: Get.arguments.Dermatologist,
                                      onChanged: (value) => controller.Dermatologist = value.trim(),
                                    )),
                              ),

                              Divider(),
                              Visibility(
                                visible: true,
                                child: ListTile(
                                    leading: Image.asset(Assets.shared.email),
                                    title: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black38),
                                      ),
                                      initialValue: Get.arguments.email,
                                      onChanged: (value) => controller.email = value.trim(),
                                    )),
                              ),

                              Divider(),
                              Visibility(
                                visible: true,
                                child: ListTile(
                                    leading: Image.asset(Assets.shared.date),
                                    title: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black38),
                                      ),
                                      initialValue: Get.arguments.Date,
                                      onChanged: (value) => controller.Date = value.trim(),
                                    )),
                              ),

                              Divider(),
                              Visibility(
                                visible: true,
                                child: ListTile(
                                    leading:
                                        Image.asset(Assets.shared.password),
                                    title: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black38),
                                      ),
                                      obscureText: true,
                                      initialValue: Get.arguments.Password,
                                      onChanged: (value) => controller.password = value.trim(),
                                    )),
                              ),
                              Divider(),

                              SizedBox(height: 20),
                              customButton(context,
                                  title: "Save changes",
                                  backgroundColor: ColorHelper.white,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  width: MediaQuery.of(context).size.width *
                                      (200 / 300),
                                  height: MediaQuery.of(context).size.height *
                                      (35 / 812), onPressed: () {
                                controller.Update_profile(context);
                              })
                            ])))))));
  }
}
