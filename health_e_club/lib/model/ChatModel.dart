import 'dart:convert';
import '../enums/Group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

class ChatModel {
  ChatModel(
      {required this.name,
      required this.photo,
      required this.Group,
      required this.uid,
      required this.users,
      this.uidSender,
      required this.uiddoctor,
      required this.uidPatient,
      this.message,
      this.createdDate,
      this.handle});

  String name;
  String photo;
  group? Group;
  String uid;
  List<dynamic> users;
  bool? handle;
  String? uidSender;
  String uiddoctor;
  String uidPatient;
  String? message;
  DateTime? createdDate;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        handle: true,
        name: json["Name"] ?? "",
        photo: json["photo"] ?? "",
        Group: group.values[json["type"] ?? 0],
        uid: json["uid"] ?? "",
        users: json["users"] ?? [],
        uidSender: json["uid_sender"] ?? "",
        uidPatient: json["uid_Patient"]??"",
        uiddoctor: json["uid_doctor"]??"",
        message: json["message"] ?? "",
        createdDate:json["createdAt"] == null ? DateTime.now() : ((json["createdAt"] as Timestamp).toDate()),
  );
}
