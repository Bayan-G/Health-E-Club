import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/enums/user_type.dart';
import '../Controller/chat_controller.dart';
import '../Widgets/assets.dart';
import '../Widgets/since_time.dart';
import '../model/ChatModel.dart';
import '../model/UserModel.dart';
import '../routes/app_routes.dart';
import '../utils/Firebase_Manager.dart';
import 'package:intl/intl.dart';

class chat extends GetView<chatController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<chatController>(
        builder: (controller) => Scaffold(
            backgroundColor: const Color(0xffD9D9D9),
            body: SafeArea(child: StreamBuilder<List<ChatModel>>(
              stream: FirebaseManager.shared.get_chat(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else if (snapshot.hasData) {
                  final Chat = <ChatModel>[].obs;
                  for (var Detail in snapshot.data!) {
                    if (Detail.name.contains(controller.searchTextField.value.text) || Detail.name.contains(controller.searchTextField.value.text)) {
                      if (Detail.name == "" && Detail.photo == "") {
                        Detail.handle = false;
                      }
                      Chat.add(Detail);
                    }
                  }

                  return SingleChildScrollView(
                      child: Column(children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text("Chats",
                            style: TextStyle(
                                color: Colors.cyan,
                                fontSize: 32,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              controller.searchTextField.value.clear();
                              Chat.clear();
                              controller.update(); //
                              //  setState(() {});
                            },
                          ),
                          title: TextField(
                            controller: controller.searchTextField.value,
                            decoration: const InputDecoration(
                                hintText: "Search", border: InputBorder.none),
                            onChanged: (value) {
                              Chat.clear;
                              if (controller.searchTextField.value.text !=
                                  null) {
                                //               setState(() {});
                                controller.update(); // ←

                                return;
                              }
                              controller.update(); // ←

                              //              setState(() {});
                            },
                          ),
                          leading: Image.asset(
                            Assets.shared.search,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                    ),
                    Wrap(
                        children: List.generate(Chat.length, (index) {
                      return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.Chats_live,
                                arguments: Chat[index]);
                          },
                          child: Card(
                            color: const Color(0xffD9D9D9),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: const Color(0xffD9D9D9),
                                      child: Chat[index].handle == false
                                          ? img(uid: Get.arguments == UserType.doctor ? Chat[index].uidPatient : Chat[index].uiddoctor)
                                          : CircleAvatar(
                                              backgroundColor: Color(0xffD9D9D9),
                                              backgroundImage:
                                                  AssetImage(Chat[index].photo),
                                              radius: 30,
                                            )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      if (Chat[index].handle == false)
                                        USER_NAME(
                                            uid:
                                                Get.arguments == UserType.doctor
                                                    ? Chat[index].uidPatient
                                                    : Chat[index].uiddoctor),
                                      if (Chat[index].handle == true)
                                        Text(
                                          Chat[index].name,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      if (Chat[index].handle == false)
                                        Last_message(
                                            uid: Chat[index].uid,
                                            time_or_message: "message"),
                                      if (Chat[index].handle == true)
                                        Last_message_G(
                                            uid: Chat[index].uid,
                                            time_or_message: "message"),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        if (Chat[index].handle == false)
                                          Last_message(
                                              uid: Chat[index].uid,
                                              time_or_message: "Time"),
                                        if (Chat[index].handle == true)
                                          Last_message_G(
                                              uid: Chat[index].uid,
                                              time_or_message: "Time"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ));
                    }))
                  ]));
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black54,
                    backgroundColor: Colors.black54,
                  ));
                }
              },
            )),
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
                        onTap: () async {
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
                ))));
  }

  Widget USER_NAME({required String uid}) {
    return FutureBuilder<UserModel>(
        future: FirebaseManager.shared.getNameUser(uid: uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel user = snapshot.data!;
            controller.Name = "${user.Frist_name!}  ${user.Last_name!}";
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

  Widget Last_message({required String uid, required String time_or_message}) {
    return StreamBuilder<ChatModel>(
        stream: FirebaseManager.shared.get_Last_message(uid: uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ChatModel handle = snapshot.data!;
            controller.Date = handle.createdDate!;
            return time_or_message == "message"
                ? Text(
                    " ${handle.message!}",
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  )
                : Text(
                    "${timeAgoSinceDate(handle.createdDate!)} "
                    "\n"
                    "${DateFormat("h:mma").format(handle.createdDate!)}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  );
          } else {
            return const SizedBox();
          }
        });
  }

  Widget Last_message_G({required String uid, required String time_or_message}) {
    return StreamBuilder<ChatModel>(
        stream: FirebaseManager.shared.get_Last_message(uid: uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ChatModel handle = snapshot.data!;
            return FutureBuilder<UserModel>(
                future:
                    FirebaseManager.shared.getNameUser(uid: handle.uidSender!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data!;
                    return time_or_message == "message"
                        ? Text(
                            "${user.Frist_name}: ${handle.message!}",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          )
                        : Text(
                            "${timeAgoSinceDate(handle.createdDate!)} "
                            "\n"
                            "${DateFormat("h:mma").format(handle.createdDate!)}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          );
                    ;
                  } else {
                    return const SizedBox();
                  }
                });
          } else {
            return const SizedBox();
          }
        });
  }

  Widget img({required String uid}) {
    return FutureBuilder<UserModel>(
        future: FirebaseManager.shared.getNameUser(uid: uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel user = snapshot.data!;
            return user.photo != ""
                ? Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(user.photo!),
                            fit: BoxFit.cover)),
                  )
                : Image.asset(Assets.shared.person_profile);
          } else {
            return const SizedBox();
          }
        });
  }
}
