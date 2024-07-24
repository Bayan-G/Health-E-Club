import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/Widgets/colors.dart';
import '../Controller/patient_appointment_controller.dart';
import '../Widgets/Select.dart';
import '../Widgets/assets.dart';
import '../Widgets/customButton.dart';
import '../routes/app_routes.dart';

class PatientAppointment extends GetView<PatientAppointmentController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientAppointmentController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                leading: Row(
                  children: [
                    SizedBox(width: 5),
                    customButton(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                      ),
                      backgroundColor: ColorHelper.white,
                      width: 50,
                      height: 33,
                      context,
                      title: 'Edit',
                      onPressed: () {
                        if (controller.Valuw != null)
                        Get.toNamed(Routes.Edit_or_Delete_appointment, arguments: controller.Valuw);
                     },
                    ),
                  ],
                ),
                automaticallyImplyLeading: false,
                title: const Text(
                  "Appointments",
                  style: TextStyle(
                    color: Color(0xFF5BC0DA),
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(70),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 250,
                            height: 45,
                            decoration: BoxDecoration(
                              color: ColorHelper.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: GetBuilder<PatientAppointmentController>(
                              builder: (tx) => Select(
                                tx.OMNIList,
                                onSelectionChanged: (selectedList) {
                                  dynamic final_omni;
                                  if (selectedList == "Previous") {
                                    final_omni = 0;
                                  }
                                  if (selectedList == "Upcoming") {
                                    final_omni = 1;
                                  }
                                  if (selectedList == "Today") {
                                    final_omni = 2;
                                  }
                                  tx.onItemTapped(final_omni);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10,)
                        ],
                      ),
                    )),
                centerTitle: true,
                backgroundColor: Color(0xFFD9D9D9),
                elevation: 0,
              ),
              backgroundColor: Color(0xFFD9D9D9),
              body: GetBuilder<PatientAppointmentController>(
                  builder: (tx) => tx.onData!.elementAt(tx.selectedIndex)),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
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
                        onTap: () {},
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
            ));
  }
}
