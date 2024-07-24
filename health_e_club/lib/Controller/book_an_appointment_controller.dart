import 'dart:async';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Widgets/extensions.dart';
import 'package:health_e_club/enums/Group.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:uuid/uuid.dart';
import '../enums/status.dart';
import '../page/Book_appointment_success.dart';
import '../utils/Firebase_Manager.dart';

class BookAnAppointment_Controller extends GetxController {

  final morningTimes = [].obs;
  final afternoonTimes = [].obs;
  final eveningTimes = [].obs;
  final nightTimes = [].obs;

  DateTime? handle = DateTime.now();
  String? bookingtime;
  DatePickerController datePickerController = DatePickerController();

  late Timer _timer;

  @override
  void onInit() async {
    super.onInit();
    getTimes();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) => getTimes());
  }

  Future getTimes({DateTime? date}) async {
    try {
      nightTimes.clear();
      morningTimes.clear();
      afternoonTimes.clear();
      eveningTimes.clear();
      List<dynamic> times = [
        ["${handle!.toString().changeDateFormat()}T00:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T00:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T01:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T01:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T02:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T02:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T03:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T03:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T04:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T04:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T05:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T05:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T06:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T06:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T07:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T07:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T08:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T08:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T09:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T09:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T10:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T10:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T11:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T11:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T12:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T12:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T13:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T13:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T14:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T14:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T15:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T15:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T16:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T16:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T17:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T17:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T18:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T18:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T19:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T19:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T20:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T20:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T21:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T21:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T22:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T22:30:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T23:00:00+02:00", true],
        ["${handle!.toString().changeDateFormat()}T23:30:00+02:00", true]
      ];
      times.sort((e1, e2) {
        final localDateTime1 = DateTime.parse(e1.elementAt(0)).toLocal();
        final hours1 = int.tryParse(DateFormat('HH').format(localDateTime1));
        final localDateTime2 = DateTime.parse(e2.elementAt(0)).toLocal();
        final hours2 = int.tryParse(DateFormat('HH').format(localDateTime2));
        return hours1!.compareTo(hours2!);
      });
      nightTimes.assignAll(times.sublist(0, 14));
      morningTimes.assignAll(times.sublist(14, 24));
      afternoonTimes.assignAll(times.sublist(24, 36));
      eveningTimes.assignAll(times.sublist(36));
    } catch (e) {
      Get.customSnackbar(
        title: "Error",
        message: e.toString(),
        isError: true,
      );
    }
  }

  void booking(
    context, {
    required String Doctor_uid,
    required String Disease,
    required String PatientId,
    required Status status,
    required DateTime booking_Date,
  }) async {
    try {
      dynamic uid = const Uuid().v4();
      FirebaseManager.shared.bookingRef.doc(uid).set({
        "DoctorId": Doctor_uid,
        "Disease": Disease,
        "PatientId": PatientId,
        "createdDate": booking_Date,
        "status": status.index,
        "uid": uid,
      }).then((value) async {
        await FirebaseManager.shared.GroupRef.doc(uid).set({
          "Name":  "",
          "photo":  "",
          "uid_Patient":  PatientId,
          "uid_doctor":  Doctor_uid,
          "type":  8,
          "uid":  uid,
          "users":  [Doctor_uid,PatientId],
        });
        showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            builder: (BuildContext context) {
              return const FractionallySizedBox(
                heightFactor: 0.50,
                child: Book_appointment_success(),
              );
            });
      }).catchError((err) {
        Get.customSnackbar(
          title: "Error",
          message: "Something went wrong",
          isError: true,
        );
      });
    } catch (e) {
      Get.customSnackbar(
        title: "Error",
        message: e.toString(),
        isError: true,
      );
    } finally {
      //         loading.value = false;
    }
  }
}
