import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Widgets/extensions.dart';
import '../Widgets/assets.dart';
import '../Widgets/flutter_calendar.dart';
import '../Widgets/isSelectionMode.dart';
import '../enums/status.dart';
import '../enums/user_type.dart';
import '../model/BookingModel.dart';
import '../model/UserModel.dart';
import '../utils/Firebase_Manager.dart';
import 'Edit_or_Delete_appointment_Controller.dart';

class PatientAppointmentController extends GetxController {
  String? selecte;

  dynamic Valuw = null;

  List<String> OMNIList = [
    "Previous",
    "Upcoming",
    "Today",
  ];

  int selectedIndex = 2;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 13, color: Colors.blue);

  List<Widget>? tabPages;
  List<Widget>? onData;

  void _handleNewDate(date) {
    print('Date selected: $date');
  }

  final _controller =
      Get.put(Edit_or_Delete_appointment_Controller(), permanent: true);

  @override
  void onInit() {
    _handleNewDate(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

    onData = <Widget>[
      FutureBuilder<UserModel?>(
          future: FirebaseManager.shared.getNameUser(uid: FirebaseManager.shared.auth.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.userType == UserType.doctor) {
                return StreamBooking_previous("DoctorId");
              } else {
                return StreamBooking_previous("PatientId");
              }
            } else {
              return Center(
                child: Image.asset(
                  Assets.shared.Logo,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * (250 / 812),
                ),
              );
            }
          }),
      FutureBuilder<UserModel?>(
          future: FirebaseManager.shared
              .getNameUser(uid: FirebaseManager.shared.auth.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.userType == UserType.doctor) {
                return StreamBooking_Upcoming("DoctorId");
              } else {
                return StreamBooking_Upcoming("PatientId");
              }
            } else {
              return Center(
                child: Image.asset(
                  Assets.shared.Logo,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * (250 / 812),
                ),
              );
            }
          }),
      FutureBuilder<UserModel?>(
          future: FirebaseManager.shared
              .getNameUser(uid: FirebaseManager.shared.auth.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.userType == UserType.doctor) {
                return StreamBooking_Today("DoctorId");
              } else {
                return StreamBooking_Today("PatientId");
              }
            } else {
              return Center(
                child: Image.asset(
                  Assets.shared.Logo,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * (250 / 812),
                ),
              );
            }
          }),
    ];

    super.onInit();
    tabPages = <Widget>[
      //  ListViewTab(omni),
      Column(
        children: [
          Image.asset(Assets.shared.omni),
          Text(
            'No Previous appointments',
            style: optionStyle,
          ),
        ],
      ),
      Column(
        children: [
          Image.asset(Assets.shared.omni),
          const Text(
            'No upcoming appointments ',
            style: optionStyle,
          ),
        ],
      ),
      Column(
        children: [
          Image.asset(Assets.shared.omni),
          const Text(
            'No Today appointments ',
            style: optionStyle,
          ),
        ],
      ),
    ];
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    update(); // ←
  }

  Widget StreamBooking_previous(String Doc) {
    return StreamBuilder<List<BookingModel>>(
        stream: FirebaseManager.shared.get_Booking(UID: FirebaseManager.shared.auth.currentUser!.uid, doc: Doc),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BookingModel> omni = [];
            for (var previous in snapshot.data!) {
              final now = DateTime.now();
              //befor
              if (now.isBefore(previous.createdDate.toUtc()) == false) {
                  omni.add(previous);
              }
            }
            final Map<DateTime, List<Calendar_Booking>> events = {
              for (var item in omni)
                DateTime(item.createdDate.year, item.createdDate.month, item.createdDate.day): List.generate(omni.length, (index) => Calendar_Booking(omni[index].DoctorId,
                            description: omni[index].Disease,
                            uid: omni[index].uid,
                            createdDate: DateTime(
                                omni[index].createdDate.year,
                                omni[index].createdDate.month,
                                omni[index].createdDate.day,
                                omni[index].createdDate.hour,
                                omni[index].createdDate.minute),
                            color: Colors.white,
                            isAllDay: false,
                            isDone: true)),
            };
            if (omni.isEmpty) {
              return Center(
                child: GetBuilder<PatientAppointmentController>(
                    builder: (tx) => tx.tabPages!.elementAt(tx.selectedIndex)),
              );
            }
            if (Doc == "DoctorId") {
              return SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(child: select(omni))));
            } else {
              return SafeArea(
                child: Calendar(
                  onEventSelected: (e) {
                    Valuw = e;
                    _controller.uid = e.uid;
                  },
                  startOnMonday: true,
                  weekDays: const ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
                  events: events,
                  isExpandable: true,
                  eventDoneColor: Colors.green,
                  selectedColor: Colors.grey,
                  todayColor: Colors.blue,
                  eventColor: Colors.black,
                  locale: 'en_US',
                  todayButtonText: 'Today',
                  isExpanded: false,
                  expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                  dayOfWeekStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 11),
                ),
              );
            }
          } else {
            return Center(
              child: Image.asset(
                Assets.shared.Logo,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * (250 / 812),
              ),
            );
          }
        });
  }

  Widget StreamBooking_Upcoming(String Doc) {
    return StreamBuilder<List<BookingModel>>(
        stream: FirebaseManager.shared.get_Booking(
            UID: FirebaseManager.shared.auth.currentUser!.uid, doc: Doc),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BookingModel> omni = [];
            // befor
            for (var Upcoming in snapshot.data!) {
              final now = DateTime.now();
              if (now.isAfter(Upcoming.createdDate.toUtc()) == false) {
                if (Upcoming.status == Status.ACTIVE) {
                  omni.add(Upcoming);
                }
              }
            }

            final Map<DateTime, List<Calendar_Booking>> events = {
              for (var item in omni)
                DateTime(item.createdDate.year, item.createdDate.month,
                        item.createdDate.day):
                    List.generate(
                        omni.length,
                        (index) => Calendar_Booking(omni[index].DoctorId,
                            description: omni[index].Disease,
                            uid: omni[index].uid,
                            createdDate: DateTime(
                                omni[index].createdDate.year,
                                omni[index].createdDate.month,
                                omni[index].createdDate.day,
                                omni[index].createdDate.hour,
                                omni[index].createdDate.minute),
                            color: Colors.white)),
            };

            if (omni.isEmpty) {
              return Center(
                child: GetBuilder<PatientAppointmentController>(
                    builder: (tx) => tx.tabPages!.elementAt(tx.selectedIndex)),
              );
            }
            if (Doc == "DoctorId") {
              return SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(child: select(omni))));
            } else {
              return SafeArea(
                child: Calendar(
                  onEventSelected: (e) {
                    Valuw = e;
                    _controller.uid = e.uid;
                  },
                  startOnMonday: true,
                  weekDays: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
                  events: events,
                  isExpandable: true,
                  onRangeSelected: (range) =>
                      print('Range is ${range.from}, ${range.to}'),
                  onDateSelected: (date) => _handleNewDate(date),
                  eventDoneColor: Colors.green,
                  selectedColor: Colors.grey,
                  todayColor: Colors.blue,
                  eventColor: Colors.black,
                  locale: 'en_US',
                  todayButtonText: 'Today',
                  isExpanded: true,
                  expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                  dayOfWeekStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 11),
                ),
              );
            }
          } else {
            return Center(
              child: Image.asset(
                Assets.shared.Logo,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * (250 / 812),
              ),
            );
          }
        });
  }

  Widget StreamBooking_Today(String Doc) {
    return StreamBuilder<List<BookingModel>>(
        stream: FirebaseManager.shared.get_Booking(
            UID: FirebaseManager.shared.auth.currentUser!.uid, doc: Doc),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //Today I'm Here
            List<BookingModel> omni = [];

            for (var Today in snapshot.data!) {
              DateTime dateToday = DateTime.now();
              String date = dateToday.toString().changeDateFormat();
              if (Today.createdDate.toString().changeDateFormat() == date) {
                  omni.add(Today);
              }
            }

            final Map<DateTime, List<Calendar_Booking>> events = {
              for (var item in omni)
                DateTime(item.createdDate.year, item.createdDate.month,
                        item.createdDate.day):
                    List.generate(
                        omni.length,
                        (index) => Calendar_Booking(omni[index].DoctorId,
                            description: omni[index].Disease,
                            uid: omni[index].uid,
                            createdDate: DateTime(
                                omni[index].createdDate.year,
                                omni[index].createdDate.month,
                                omni[index].createdDate.day,
                                omni[index].createdDate.hour,
                                omni[index].createdDate.minute),
                            color: Colors.white)),
            };

            if (omni.isEmpty) {
              return Center(
                child: GetBuilder<PatientAppointmentController>(
                    builder: (tx) => tx.tabPages!.elementAt(tx.selectedIndex)),
              );
            }
            if (Doc == "DoctorId") {
              return SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(child: select(omni))));
            } else {
              return SafeArea(
                child: Calendar(
                  onEventSelected: (e) {
                    Valuw = e;
                    _controller.uid = e.uid;
                  },
                  startOnMonday: true,
                  weekDays: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
                  events: events,
                  isExpandable: true,
                  onRangeSelected: (range) =>
                      print('Range is ${range.from}, ${range.to}'),
                  onDateSelected: (date) => _handleNewDate(date),
                  eventDoneColor: Colors.green,
                  selectedColor: Colors.grey,
                  todayColor: Colors.blue,
                  eventColor: Colors.black,
                  locale: 'en_US',
                  todayButtonText: 'Today',
                  isExpanded: true,
                  expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                  dayOfWeekStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 11),
                ),
              );
            }
          } else {
            return Center(
              child: Image.asset(
                Assets.shared.Logo,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * (250 / 812),
              ),
            );
          }
        });
  }
}
