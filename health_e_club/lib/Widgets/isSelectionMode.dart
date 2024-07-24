import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../Controller/Edit_or_Delete_appointment_Controller.dart';
import '../Controller/patient_appointment_controller.dart';
import '../model/UserModel.dart';
import '../page/book_an_appointment.dart';
import '../utils/Firebase_Manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class select extends StatefulWidget {
  dynamic omni;

  select(this.omni);

  @override
  _selectState createState() => _selectState();
}

class _selectState extends State<select> {
  final controller = Get.put(PatientAppointmentController(), permanent: true);
  final _controller = Get.put(Edit_or_Delete_appointment_Controller(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: List.generate(widget.omni.length, (index) {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Colors.white),
              ),
              child: Column(children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            USER_NAME(item: widget.omni[index].PatientId),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              DateFormat("h:mma")
                                  .format(widget.omni[index].createdDate),
                              style: const TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color:Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        elevation: 0,
                        child: Select(
                          backgroundColor: Colors.white,
                          styleColor: Colors.white,
                          id: widget.omni[index].uid,
                          onSelected: (id) {
                            controller.Valuw = widget.omni[index];
                            _controller.uid = id;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ])));
    }));
  }

  Widget USER_NAME({required String item}) {
    return FutureBuilder<UserModel>(
        future: FirebaseManager.shared.getNameUser(uid: item),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel user = snapshot.data!;
            return Text(
              textAlign: TextAlign.start,
              "${user.Frist_name!}  ${user.Last_name!}",
              style: const TextStyle(color: Colors.black, fontSize: 15),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}

class Select extends StatelessWidget {
  Select({
    Key? key,
    required this.onSelected,
    required this.id,
    required this.styleColor,
    required this.backgroundColor,
  }) : super(key: key);

  final dynamic id;
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
        label: SizedBox(),
        backgroundColor: _backgroundColor,
        selectedColor: styleColor,
        selected: controller.isSelected(this.id),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        showCheckmark: true,
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
