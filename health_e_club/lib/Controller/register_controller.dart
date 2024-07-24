/*
 * Copyright (c) 2022   omnni
 */

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_e_club/Widgets/extensions.dart';
import 'package:health_e_club/utils/Firebase_Manager.dart';
import '../enums/user_type.dart';
import '../pin_code_fields.dart';
import '../routes/app_routes.dart';
import 'package:intl/intl.dart';
class registerController extends GetxController {

  String? Frist_name;
  String? Last_name;
  String? Medical_license;
  String? phone;
  String? email;
  String? uid;
  String? Diabetes;
  String? Dermatologist;
  String? experience;
  String? Gender;
  String? password;
  String? Confirm_password;
  String img = "";
  RxBool sec = true.obs;

  RxBool verified = true.obs;
  RxBool loading = false.obs;
  RxBool otp = false.obs;
  String? verificationId;
  String? OTP;

  UserType? Type;

  final GlobalKey<FormState> registerFormKey = GlobalKey();
  StreamController<ErrorAnimationType>? errorController;

  final omni = true.obs;

  DateTime? _selectedDate;

  TextEditingController dateOfBirth = TextEditingController();
  selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
        firstDate: DateTime(1800),
        lastDate:  DateTime.now());

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      dateOfBirth
        ..text = DateFormat.yMMMd().format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dateOfBirth.text.length, affinity: TextAffinity.upstream));
    }
 }
  var visable = const Icon(
    Icons.visibility,
    color: Color(0xff5BC0DA),
  );
  var visableoff = const Icon(
    Icons.visibility_off,
    color: Color(0xff5BC0DA),
  );
  var verifie = const Icon(
    Icons.verified,
    color: Color(0xff5BC0DA),
  );
  var date_range = const Icon(
    Icons.date_range,
    color: Color(0xff5BC0DA),
  );

  Func() {
    sec(!sec.value);
  }

  ErrorCliek() {
    Get.customSnackbar(
      title: "Error",
      message: "please Wait ErrorClick",
      isError: true,
    );
  }

  @override
  void onInit() {
    super.onInit();
    update(); // ← rebuilds any GetBuilder<TabX> widget
  }

  void createtUser(context) async {
    Get.focusScope!.unfocus();
    registerFormKey.currentState!.save();
    if (registerFormKey.currentState!.validate()) {
      loading.value = true;
      try {
        if (!email!.isValidEmail()) {
          Get.customSnackbar(
            title: "Error",
            message: "please enter a valid email",
            isError: true,
          );
          return;
        }
        otp.value = true;
        SendCode(context);
      } catch (e) {
        Get.customSnackbar(
          title: "Error",
          message: e.toString(),
          isError: true,
        );
      } finally {
        loading.value = false;
      }
    }
  }


  Future<void> SendCode(context) async {
    try {
      loading.value = true;
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+966 $phone",
          verificationCompleted: (phoneCredentials) => createAccount(phoneCredentials, context),
          verificationFailed: (error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message!))),
          codeSent: (verificationId, resendToken) {
              this.verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (verificationId) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("انتهت مهلة استرداد الرمز التلقائي"))));
      loading.value = false;
    } catch (e) {
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }

  Future<void> verifyPhone(context) async {
    try {
      loading.value = true;
      var cred = PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: OTP!);
      await createAccount(cred, context);
      loading.value = false;
    } catch (e) {
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }


  Future<void> createAccount(PhoneAuthCredential cred, BuildContext context) async {
    try {
      final result = await FirebaseAuth.instance.signInWithCredential(cred);
      final Firebase = FirebaseAuth.instance.currentUser;
      await Firebase?.updateEmail(email!);
      await Firebase?.updateDisplayName("$Frist_name $Last_name");
      await FirebaseManager.shared.auth.currentUser!.updatePassword(password!);
      if (result.user!.emailVerified == false){
        await result.user!.sendEmailVerification();
      }
      FirebaseManager.shared.userRef.doc(result.user!.uid).set({
        "First_name": Frist_name,
        "Last_name": Last_name,
        "Medical_license": Medical_license,
        "phone": phone,
        "photo": img,
        "email": email,
        "Gender": Gender,
        "verifiedPhone": true,
        "Password": password,
        "Date": _selectedDate.toString().changeDateFormat(),
        "type-user": Type!.index,
        "uid": result.user!.uid,
      }).then((value) async {
        Get.toNamed(Routes.vieryemail);
      }).catchError((err) {
        Get.customSnackbar(
          title: "Error",
          message: "Something went wrong",
          isError: true,
        );
      });
    } on FirebaseException catch (e) {
      print("Failed with error '${e.code}': ${e.message}");
      String? message;
      if (e.code == 'invalid-verification-code') {
        message = "رمز التحقق غير صالح";
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message!)));

    }
  }


  item(context, {required UserType userType}) {
    String title;
    switch (userType) {
      case UserType.doctor:
        title = "doctor";

        break;
      case UserType.Patient:
        title = "Patient";
        break;
    }

    return InkWell(
      onTap: () {
        Type = userType;
        Get.toNamed(Routes.register);
        omni.value = true;
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            height: 40,
            width: 140,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
