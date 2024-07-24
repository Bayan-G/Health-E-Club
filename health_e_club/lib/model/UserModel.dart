import 'dart:convert';
import '../enums/user_type.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  UserModel({
    this.Frist_name,
    this.photo,
    this.Last_name,
    this.Medical_license,
    this.phone,
    this.experience,
    this.Diabetes,
    this.email,
    this.userType,
    this.uid,
    this.Date,
    this.Dermatologist,
    this.Gender,
    this.Password,
    this.verifiedPhone,
  });

  String? photo;
  String? Frist_name;
  String? Last_name;
  String? Medical_license;
  String? phone;
  String? experience;
  String? Diabetes;
  String? Dermatologist;
  String? Gender;
  String? email;
  UserType? userType;
  String? Date;
  String? uid;
  String? Password;
  bool? verifiedPhone;

  factory UserModel.fromJson(Map<String, dynamic>? json) => UserModel(
        Frist_name: json!["First_name"],
        photo: json["photo"],
        Last_name: json["Last_name"],
        Medical_license: json["Medical_license"],
        phone: json["phone"],
        Diabetes: json["Diabetes"],
        Dermatologist: json["Dermatologist"],
        experience: json["experience"],
        Gender: json["Gender"],
        email: json["email"],
        Date: json["Date"],
        userType: UserType.values[json["type-user"]],
        uid: json["uid"],
        Password: json["Password"],
        verifiedPhone: json["verifiedPhone"] ?? false,
      );
}
