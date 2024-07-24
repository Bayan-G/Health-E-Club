// To parse this JSON data, do

//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/status.dart';

BookingModel bookingModelFromJson(String str) =>
    BookingModel.fromJson(json.decode(str));

class BookingModel {
  BookingModel({
    required this.DoctorId,
    required this.Disease,
    required this.PatientId,
    required this.createdDate,
    required this.status,
    required this.uid,
  });

  String DoctorId;
  String Disease;
  String PatientId;
  DateTime createdDate;
  Status status;
  String uid;

  factory BookingModel.fromJson(Map<String, dynamic>? json) => BookingModel(
        DoctorId: json!["DoctorId"],
        Disease: json["Disease"],
        PatientId: json["PatientId"],
        createdDate: json["createdDate"] =
            ((json["createdDate"] as Timestamp).toDate()),
        status: Status.values[json["status"]],
        uid: json["uid"],
      );
}
