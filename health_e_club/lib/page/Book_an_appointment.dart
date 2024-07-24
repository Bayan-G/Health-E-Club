import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Controller/book_an_appointment_controller.dart';
import 'package:health_e_club/Widgets/extensions.dart';
import '../Widgets/assets.dart';
import '../Widgets/colors.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../Widgets/customButton.dart';
import '../enums/status.dart';
import '../utils/Firebase_Manager.dart';

class BookAnAppointmentScreen extends GetView<BookAnAppointment_Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: RefreshIndicator(
          onRefresh: () async {
            await controller.onInit;
          },
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Center(
                  child: Text(
                    "Book An Appointment",
                    style: TextStyle(
                      color: ColorHelper.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DatePicker(
                    DateTime.now(),
                    width: 60,
                    height: 90,
                    daysCount: 30,
                    controller: controller.datePickerController,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Get.theme.colorScheme.secondary,
                    selectedTextColor: Colors.white,
                    deactivatedColor: Colors.white,
                    onDateChange: (date) async {
                      controller.handle = date;
                      await controller.getTimes(date: controller.handle!);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Available Time',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Obx(() {
                  if (controller.morningTimes.isEmpty) {
                    return TabBarLoadingWidget();
                  } else {
                    return TabBarWidget(
                      initialSelectedId: "",
                      tabs: List.generate(controller.morningTimes.length,
                          (index) {
                        final _time = controller.morningTimes
                            .elementAt(index)
                            .elementAt(0);
                        bool _available = controller.morningTimes
                            .elementAt(index)
                            .elementAt(1);
                        if (_available) {
                          return ChipWidget(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            style: Get.textTheme.bodyText1!
                                .merge(TextStyle(color: Colors.black)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            text: DateFormat('h:mma')
                                .format(DateTime.parse(_time).toLocal()),
                            id: _time,
                            onSelected: (id) {
                              controller.bookingtime = id;
                            },
                          );
                        } else {
                          return RawChip(
                            elevation: 0,
                            label: Text(
                                DateFormat('h:mma')
                                    .format(DateTime.parse(_time).toLocal()),
                                style: Get.textTheme.caption),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            backgroundColor: Colors.white.withOpacity(0.2),
                            selectedColor: Get.theme.colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            showCheckmark: false,
                            pressElevation: 0,
                          ).marginSymmetric(horizontal: 5);
                        }
                      }),
                    );
                  }
                }),
                Obx(() {
                  if (controller.afternoonTimes.isEmpty) {
                    return TabBarLoadingWidget();
                  } else {
                    return TabBarWidget(
                      initialSelectedId: "",
                      tabs: List.generate(controller.afternoonTimes.length,
                          (index) {
                        final _time = controller.afternoonTimes
                            .elementAt(index)
                            .elementAt(0);
                        bool _available = controller.afternoonTimes
                            .elementAt(index)
                            .elementAt(1);
                        if (_available) {
                          return ChipWidget(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            style: Get.textTheme.bodyText1!
                                .merge(TextStyle(color: Colors.black)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            text: DateFormat('h:mma')
                                .format(DateTime.parse(_time).toLocal()),
                            id: _time,
                            onSelected: (id) {
                              controller.bookingtime = id;
                            },
                          );
                        } else {
                          return RawChip(
                            elevation: 0,
                            label: Text(
                                DateFormat('h:mma')
                                    .format(DateTime.parse(_time).toLocal()),
                                style: Get.textTheme.caption),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            backgroundColor: Colors.white.withOpacity(0.2),
                            selectedColor: Get.theme.colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            showCheckmark: false,
                            pressElevation: 0,
                          ).marginSymmetric(horizontal: 5);
                        }
                      }),
                    );
                  }
                }),
                Obx(() {
                  if (controller.eveningTimes.isEmpty) {
                    return TabBarLoadingWidget();
                  } else {
                    return TabBarWidget(
                      initialSelectedId: "",
                      tabs: List.generate(controller.eveningTimes.length,
                          (index) {
                        final _time = controller.eveningTimes
                            .elementAt(index)
                            .elementAt(0);
                        bool _available = controller.eveningTimes
                            .elementAt(index)
                            .elementAt(1);
                        if (_available) {
                          return ChipWidget(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            style: Get.textTheme.bodyText1!
                                .merge(TextStyle(color: Colors.black)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            text: DateFormat('h:mma')
                                .format(DateTime.parse(_time).toLocal()),
                            id: _time,
                            onSelected: (id) {
                              controller.bookingtime = id;
                            },
                          );
                        } else {
                          return RawChip(
                            elevation: 0,
                            label: Text(
                                DateFormat('h:mma')
                                    .format(DateTime.parse(_time).toLocal()),
                                style: Get.textTheme.caption),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            backgroundColor:
                                Get.theme.focusColor.withOpacity(0.1),
                            selectedColor: Get.theme.colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            showCheckmark: false,
                            pressElevation: 0,
                          ).marginSymmetric(horizontal: 5);
                        }
                      }),
                    );
                  }
                }),
                Obx(() {
                  if (controller.nightTimes.isEmpty) {
                    return TabBarLoadingWidget();
                  } else {
                    return TabBarWidget(
                      initialSelectedId: "",
                      tabs:
                          List.generate(controller.nightTimes.length, (index) {
                        final _time =
                            controller.nightTimes.elementAt(index).elementAt(0);
                        bool _available =
                            controller.nightTimes.elementAt(index).elementAt(1);
                        if (_available) {
                          return ChipWidget(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            style: Get.textTheme.bodyText1!
                                .merge(TextStyle(color: Colors.black)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            text: DateFormat('h:mma')
                                .format(DateTime.parse(_time).toLocal()),
                            id: _time,
                            onSelected: (id) {
                              controller.bookingtime = id;
                            },
                          );
                        } else {
                          return RawChip(
                            elevation: 0,
                            label: Text(
                                DateFormat('h:mma')
                                    .format(DateTime.parse(_time).toLocal()),
                                style: Get.textTheme.caption),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            backgroundColor:
                                Get.theme.focusColor.withOpacity(0.1),
                            selectedColor: Get.theme.colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            showCheckmark: false,
                            pressElevation: 0,
                          ).marginSymmetric(horizontal: 5);
                        }
                      }),
                    );
                  }
                }),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customButton(context,
                          title: 'Confirm',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ), onPressed: () {
                        if (controller.bookingtime == null) {
                          Get.customSnackbar(
                            title: "Error",
                            message: "Please Confirm a time",
                            isError: true,
                          );
                        } else {
                          controller.booking(context,
                              booking_Date:
                                  DateTime.parse(controller.bookingtime!)
                                      .toLocal(),
                              Doctor_uid: Get.arguments.uid!,
                              Disease: Get.arguments.Dermatologist!,
                              PatientId:
                                  FirebaseManager.shared.auth.currentUser!.uid,
                              status: Status.ACTIVE);
                        }
                      }, backgroundColor: Colors.white, width: 126, height: 29),
                    ],
                  ),
                ),
              ],
            ),
          )),
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
                onTap: () {
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
                onTap: () {
                  Get.toNamed('/home');
                },
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
        ),
      ),
    );
  }
}

class TabBarLoadingWidget extends StatelessWidget implements PreferredSize {
  Widget buildTabBar() {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      height: 60,
      child: ListView(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: List.generate(
          4,
          (index) => RawChip(
            elevation: 0,
            label: Text(''),
            padding: EdgeInsets.symmetric(
                horizontal: 20.0 * (index + 1), vertical: 15),
            backgroundColor: Get.theme.focusColor.withOpacity(0.1),
            selectedColor: Get.theme.colorScheme.secondary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            showCheckmark: false,
            pressElevation: 0,
          ).marginSymmetric(horizontal: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildTabBar();
  }

  @override
  Widget get child => buildTabBar();

  @override
  Size get preferredSize => new Size(Get.width, 60);
}

class TabBarWidget extends StatelessWidget implements PreferredSize {
  TabBarWidget(
      {Key? key, required this.tabs, required this.initialSelectedId}) {
    tabs[0] = Padding(
        padding: EdgeInsetsDirectional.only(start: 15),
        child: tabs.elementAt(0));
    tabs[tabs.length - 1] = Padding(
        padding: EdgeInsetsDirectional.only(end: 15),
        child: tabs[tabs.length - 1]);
  }

  final dynamic initialSelectedId;
  final List<Widget> tabs;

  Widget buildTabBar() {
    final controller = Get.put(TabBarController(), permanent: true);
    if (controller.selectedId!.firstRebuild) {
      controller.selectedId!.value = initialSelectedId.toString();
    }
    return Container(
      alignment: AlignmentDirectional.centerStart,
      height: 60,
      child: ListView(
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: tabs),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildTabBar();
  }

  @override
  Widget get child => buildTabBar();

  @override
  Size get preferredSize => new Size(Get.width, 60);
}

class TabBarController extends GetxController {
  RxString? selectedId;

  @override
  void onInit() {
    super.onInit();
  }

  TabBarController() {
    selectedId = RxString("");
  }

  bool isSelected(dynamic tabId) => selectedId!.value == tabId.toString();

  void toggleSelected(
    dynamic tabId,
  ) {
    if (!isSelected(tabId)) {
      selectedId!.value = tabId.toString();
    }
  }
}

class ChipWidget extends StatelessWidget {
  ChipWidget({
    Key? key,
    required this.text,
    required this.onSelected,
    required this.id,
    required this.style,
    required this.padding,
    required this.backgroundColor,
  }) : super(key: key);

  final String text;
  final dynamic id;
  final TextStyle style;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final ValueChanged<dynamic> onSelected;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabBarController(), permanent: true);
    TextStyle? _style = style;
    EdgeInsetsGeometry _padding = padding;
    Color _backgroundColor = backgroundColor;
    return Obx(() {
      return RawChip(
        elevation: 0,
        label: Text(text),
        labelStyle: controller.isSelected(this.id)
            ? _style.merge(TextStyle(color: Get.theme.primaryColor))
            : _style,
        padding: _padding,
        backgroundColor: _backgroundColor,
        selectedColor: Colors.white.withOpacity(0.2),
        selected: controller.isSelected(this.id),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        showCheckmark: false,
        pressElevation: 0,
        onSelected: (bool value) {
          controller.toggleSelected(this.id);
          onSelected(id);
        },
      ).marginSymmetric(horizontal: 5);
    });
  }
}
