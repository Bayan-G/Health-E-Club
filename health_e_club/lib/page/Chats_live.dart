import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/utils/Firebase_Manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Controller/chat_controller.dart';
import '../Widgets/since_time.dart';
import '../model/ChatModel.dart';
import '../model/UserModel.dart';

class Chats_live extends GetView<chatController> {
  var sendMessageController = TextEditingController();

  Color color_selected = Color.fromRGBO(40, 114, 159, 1.0);

  Color my_message_color = Colors.blue;

  Color sender_message_color = Colors.grey;

  Color TextColors = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffD9D9D9),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: color_selected,
            ),
          ),
          centerTitle: true,
          title: Text(
            "${Get.arguments.name == "" ? controller.Name : Get.arguments.name}"
                "\n"
                "${Get.arguments.name == "" ? timeAgoSinceDate(controller.Date) : "${Get.arguments.users.length} members"}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: const Color(0xffD9D9D9),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<ChatModel>>(
                      stream: FirebaseManager.shared.get_message(uid: Get.arguments.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<ChatModel> messages = [];
                          for (var message in snapshot.data!) {
                            messages.add(message);
                          }
                          messages.sort((a, b) {
                            return a.createdDate!.compareTo(b.createdDate!);
                          });

                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 30,
                            ),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return _item(message: messages[index]);
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                        controller: sendMessageController,
                        decoration: const InputDecoration(
                          hintText: "Enter Text",
                          border: InputBorder.none,
                        ),
                        onSubmitted: (v) {
                          if (sendMessageController.text.trim() != "") {
                            _sendMessage(
                              message: sendMessageController.text.trim(),
                            );
                            sendMessageController.text = "";
                          }
                        }),
                  ),
                  SizedBox(
                    width: 35,
                    child: IconButton(
                      icon: Icon(
                        Icons.insert_emoticon_sharp,
                        color: color_selected,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget _item({required ChatModel message}) {
    bool myMessage =
        message.uidSender != FirebaseManager.shared.auth.currentUser!.uid;
    return Row(
        mainAxisAlignment:
            myMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
                color: myMessage ? sender_message_color : my_message_color,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                    bottomLeft: myMessage
                        ? const Radius.circular(15)
                        : const Radius.circular(15),
                    bottomRight: myMessage
                        ? const Radius.circular(15)
                        : const Radius.circular(15))),
            width: message.message!.isEmpty
                ? 200
                : min(message.message!.length * 20 + 40, 200),
            child: Column(
              children: [
                if (myMessage) USER_NAME(item: message.uidSender!),
                Text(
                  message.message!,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: TextColors, fontSize: 15),
                ),
              ],
            ),
          ),
        ]);
  }

  Widget USER_NAME({required String item}) {
    return FutureBuilder<UserModel>(
        future: FirebaseManager.shared.getNameUser(uid: item),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel user = snapshot.data!;
            return Text(
              textAlign: TextAlign.start,
              user.Frist_name!,
              style: const TextStyle(color: Colors.black, fontSize: 11),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  _sendMessage({required String message}) async {
    await FirebaseFirestore.instance
        .collection('chat').doc(Get.arguments.uid).collection("message")
        .add({
      'message': message,
      'uid_sender': FirebaseManager.shared.auth.currentUser!.uid,
      'createdAt': DateTime.now(),
    });
  }
}
