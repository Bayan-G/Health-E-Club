import 'package:flutter/material.dart';

class Calendar_Booking {
  String Doctor_NAME;
  String description;
  String uid;
  DateTime createdDate;
  DateTime? endTime;
  Color color;
  bool isAllDay;
  bool isDone;

  Calendar_Booking(this.Doctor_NAME,
      {this.description = '',
      this.uid = '',
      required this.createdDate, this.endTime,
      this.color = Colors.blue,
      this.isAllDay = false,
      this.isDone = false
      });
}
