import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Widgets/extensions.dart';
import 'package:health_e_club/enums/user_type.dart';
import 'package:health_e_club/pin_code_fields.dart';
import '../Controller/register_controller.dart';
import '../Widgets/assets.dart';
import '../Widgets/colors.dart';
import '../Widgets/customButton.dart';
import 'book_an_appointment.dart';

class registerPage extends GetView<registerController> {
  Widget build(BuildContext context) {
    return GetBuilder<registerController>(
        builder: (controller) => Scaffold(
              backgroundColor: const Color(0xffD9D9D9),
              appBar: AppBar(
                backgroundColor: Colors.blue,
                automaticallyImplyLeading: false,
                elevation: 0,
                leading: IconButton(
                  isSelected: true,
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xffD9D9D9),
                    child: Icon(Icons.arrow_back_ios,
                        color: Get.theme.primaryColor),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              body: SingleChildScrollView(
                  child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Form(
                          key: controller.registerFormKey,
                          child: Obx(() {
                            if (controller.otp.isTrue) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Phone Verification",
                                        style: TextStyle(
                                            color: Color(0xFF5BC0DA),
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  Text(
                                    "We sent the OTP code to your phone, please check it and enter below",
                                    style: Get.textTheme.bodyText1,
                                    textAlign: TextAlign.center,
                                  ).paddingSymmetric(
                                      horizontal: 20, vertical: 20),
                                  PinCodeTextField(
                                    appContext: context,
                                    pastedTextStyle: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    length: 6,
                                    obscureText: true,
                                    obscuringCharacter: '*',
                                    blinkWhenObscuring: true,
                                    animationType: AnimationType.fade,
                                    validator: (v) {
                                      if (v!.length < 6) {
                                        return "I'm from Flutter";
                                      } else {
                                        return null;
                                      }
                                    },
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      activeColor: Colors.blue.shade100,
                                      inactiveColor: Colors.blue,
                                      selectedFillColor: Colors.white,
                                      inactiveFillColor: Colors.blue.shade100,
                                      selectedColor: Colors.blue,
                                      activeFillColor: Colors.white,
                                    ),
                                    cursorColor: Colors.black,
                                    animationDuration:
                                        const Duration(milliseconds: 300),
                                    enableActiveFill: true,
                                    errorAnimationController:
                                        controller.errorController,
                                    //        controller: textEditingController,
                                    keyboardType: TextInputType.number,
                                    boxShadows: const [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        color: Colors.black12,
                                        blurRadius: 10,
                                      )
                                    ],
                                    onChanged: (input) =>
                                        controller.OTP = input,
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  customButton(context,
                                      title: "Verify",
                                      backgroundColor: ColorHelper.blue,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      width: 150,
                                      height: 40, onPressed: () async {
                                    await controller.verifyPhone(context);
                                  }),
                                ],
                              );
                            } else {
                              return SingleChildScrollView(
                                  child: Column(children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Sign up",
                                      style: TextStyle(
                                          color: Color(0xFF5BC0DA),
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                          offset: Offset(4, 4)),
                                    ],
                                  ),
                                  padding: EdgeInsets.all(30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        "Frist name",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 3),
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        height: 35,
                                        child: TextFormField(
                                          initialValue:
                                              controller.Frist_name ?? "",
                                          onSaved: (value) => controller
                                              .Frist_name = value!.trim(),
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
                                          ).copyWith(hintText: "Frist name"),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "Last Name",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 3),
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        height: 35,
                                        child: TextFormField(
                                          initialValue:
                                              controller.Last_name ?? "",
                                          onSaved: (value) => controller
                                              .Last_name = value!.trim(),
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
                                          ).copyWith(hintText: "Last Name"),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const SizedBox(height: 5),
                                      Visibility(
                                        visible:
                                            controller.Type == UserType.doctor,
                                        child: const Text(
                                          "Medical licese",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Visibility(
                                        visible:
                                            controller.Type == UserType.doctor,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          height: 35,
                                          child: TextFormField(
                                            initialValue:
                                                controller.Medical_license ??
                                                    "",
                                            onSaved: (value) =>
                                                controller.Medical_license =
                                                    value!.trim(),
                                            style: const TextStyle(
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  right: 30,
                                                  left: 30),
                                              hintStyle: TextStyle(
                                                  color: Colors.black38),
                                            ).copyWith(
                                                hintText: "Medical licese"),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "Phone number",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 3),
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        height: 35,
                                        child: TextFormField(
                                          initialValue: controller.phone ?? "",
                                          onSaved: (value) =>
                                              controller.phone = value!.trim(),
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
                                          ).copyWith(
                                              hintText: "Example 555555555"),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "Email",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 3),
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        height: 35,
                                        child: TextFormField(
                                          initialValue: controller.email ?? "",
                                          onSaved: (value) =>
                                              controller.email = value!.trim(),
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                right: 30,
                                                left: 30),
                                          ).copyWith(hintText: "Email"),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Password",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 3),
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        height: 35,
                                        child: TextFormField(
                                          initialValue:
                                              controller.password ?? "",
                                          onSaved: (value) => controller
                                              .password = value!.trim(),
                                          obscureText: controller.sec.value,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    right: 30,
                                                    left: 30),
                                            suffixIcon: IconButton(
                                                color: Colors.cyan,
                                                onPressed: () =>
                                                    controller.Func(),
                                                icon: controller.sec.value
                                                    ? controller.visableoff
                                                    : controller.visable),
                                            hintStyle: const TextStyle(
                                                color: Colors.black38),
                                          ).copyWith(hintText: "Password"),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "Confirm Password",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 3),
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        height: 35,
                                        child: TextFormField(
                                          initialValue:
                                              controller.Confirm_password ?? "",
                                          onSaved: (value) => controller
                                              .Confirm_password = value!.trim(),
                                          obscureText: controller.sec.value,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    right: 30,
                                                    left: 30),
                                            suffixIcon: IconButton(
                                                color: Colors.cyan,
                                                onPressed: () =>
                                                    controller.Func(),
                                                icon: controller.sec.value
                                                    ? controller.visableoff
                                                    : controller.visable),
                                            hintStyle: const TextStyle(
                                                color: Colors.black38),
                                          ).copyWith(
                                              hintText: "Confirm Password"),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "Date of Birth",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 3),
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        height: 35,
                                        child: TextFormField(
                                          controller: controller.dateOfBirth,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    right: 30,
                                                    left: 30),
                                            suffixIcon: IconButton(
                                                color: Colors.cyan,
                                                onPressed: () => controller
                                                    .selectDate(context),
                                                icon: controller.date_range),
                                            hintStyle: const TextStyle(
                                                color: Colors.black38),
                                          ).copyWith(hintText: "Date of Birth"),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Select_regiter(
                                              backgroundColor: Colors.white,
                                              img: Assets.shared.male,
                                              styleColor: Colors.white,
                                              id: "male",
                                              onSelected: (id) {
                                                controller.Gender = id;
                                              },
                                            ),
                                            Select_regiter(
                                              backgroundColor: Colors.white,
                                              img: Assets.shared.female,
                                              styleColor: Colors.white,
                                              id: "female",
                                              onSelected: (id) {
                                                controller.Gender = id;
                                              },
                                            ),
                                            const SizedBox(width: 30),
                                          ]),
                                    ],
                                  ),
                                )),
                                const SizedBox(
                                  height: 30,
                                ),
                                customButton(
                                  context,
                                  title: "Sign Up",
                                  backgroundColor: ColorHelper.blue,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  width: 150,
                                  height: 40,
                                  onPressed: controller.loading.value
                                      ? controller.ErrorCliek
                                      : () {
                                          if (controller.Type ==
                                              UserType.doctor) {
                                            if (controller.Frist_name != null ||
                                                controller.Last_name != null ||
                                                controller.Medical_license !=
                                                    null ||
                                                controller.phone != null ||
                                                controller.email != null ||
                                                controller.password != null ||
                                                controller.Confirm_password !=
                                                    null ||
                                                controller.dateOfBirth !=
                                                    null ||
                                                controller.Gender != null) {
                                              if (controller.password ==
                                                  controller.Confirm_password) {
                                                controller.createtUser(context);
                                              } else {
                                                Get.customSnackbar(
                                                  title: "Error",
                                                  message:
                                                      "please Entire Password",
                                                  isError: true,
                                                );
                                              }
                                            } else {
                                              Get.customSnackbar(
                                                title: "Error",
                                                message: "please enter a valid",
                                                isError: true,
                                              );
                                            }
                                          } else {
                                            if (controller.Frist_name != null ||
                                                controller.Last_name != null ||
                                                controller.phone != null ||
                                                controller.email != null ||
                                                controller.password != null ||
                                                controller.Confirm_password !=
                                                    null ||
                                                controller.dateOfBirth !=
                                                    null ||
                                                controller.Gender != null) {
                                              if (controller.password ==
                                                  controller.Confirm_password) {
                                                controller.createtUser(context);
                                              } else {
                                                Get.customSnackbar(
                                                  title: "Error",
                                                  message:
                                                      "please Entire Password",
                                                  isError: true,
                                                );
                                              }
                                            } else {
                                              Get.customSnackbar(
                                                title: "Error",
                                                message: "please enter a valid",
                                                isError: true,
                                              );
                                            }
                                          }
                                        },
                                )
                              ]));
                            }
                          })),
                    ],
                  ),
                ),
              )),
            ));
  }
}

class Select_regiter extends StatelessWidget {
  Select_regiter({
    Key? key,
    required this.onSelected,
    required this.id,
    required this.img,
    required this.styleColor,
    required this.backgroundColor,
  }) : super(key: key);

  final dynamic id;
  final dynamic img;
  final Color backgroundColor;
  final Color styleColor;

  final ValueChanged<dynamic> onSelected;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabBarController(), permanent: true);
    Color _backgroundColor = backgroundColor;

    return Obx(() {
      return RawChip(
        elevation: 0,
        label: controller.isSelected(this.id)
            ? Image.asset(img, color: Colors.lightBlueAccent)
            : Image.asset(img),
        backgroundColor: _backgroundColor,
        selectedColor: styleColor,
        selected: controller.isSelected(this.id),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        showCheckmark: false,
        checkmarkColor: Colors.blue,
        pressElevation: 0,
        onSelected: (bool value) {
          controller.toggleSelected(this.id);
          onSelected(id);
        },
      );
    });
  }
}
