import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Widgets/showAlertDialog.dart';
import '../model/BookingModel.dart';
import '../model/ChatModel.dart';
import '../model/UserModel.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../routes/app_routes.dart';
import '../unknown/unknown_route.dart';
import 'package:uuid/uuid.dart';

class FirebaseManager {
  static final FirebaseManager shared = FirebaseManager();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firebase = FirebaseAuth.instance.currentUser;

  final storageRef = FirebaseStorage.instance.ref();

  final userRef = FirebaseFirestore.instance.collection('User');
  final GroupRef = FirebaseFirestore.instance.collection('chat');
  final bookingRef = FirebaseFirestore.instance.collection('booking');



  Stream<UserModel> getUserByUid({required String? uid}) {
    return userRef.doc(uid).snapshots().map((QueryDocumentSnapshot) {
      return UserModel.fromJson(QueryDocumentSnapshot.data() ?? {});
    });
  }

  Stream<List<UserModel>> get_Doctor({required String? Dermatologist}) {
    return userRef.where("Dermatologist", isEqualTo: Dermatologist).snapshots().map((QueryDocumentSnapshot) {
      return QueryDocumentSnapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<BookingModel>> get_Booking({required String UID ,required String doc}) {
    return bookingRef.where(doc, isEqualTo: UID).snapshots().map((QueryDocumentSnapshot) {
      return QueryDocumentSnapshot.docs.map((doc) {
        return BookingModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<ChatModel>> get_Group() {
    return GroupRef.snapshots().map((QueryDocumentSnapshot) {
      return QueryDocumentSnapshot.docs.map((doc) {
        return ChatModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<ChatModel>> get_message({required String? uid}) {
    return GroupRef.doc(uid).collection("message").orderBy('createdAt', descending: true).snapshots().map((QueryDocumentSnapshot) {
      return QueryDocumentSnapshot.docs.map((doc) {
        return ChatModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<ChatModel> get_Last_message({required String? uid}) {
    return GroupRef.doc(uid).collection("message").orderBy('createdAt', descending: true).snapshots().map((QueryDocumentSnapshot) {
      return QueryDocumentSnapshot.docs.map((doc) {
        return ChatModel.fromJson(doc.data());
      }).first;
    });
  }

  Stream<List<ChatModel>> get_chat() {
    return GroupRef.where("users", arrayContainsAny: [auth.currentUser!.uid]).snapshots().map((QueryDocumentSnapshot) {
      return QueryDocumentSnapshot.docs.map((doc) {
        return ChatModel.fromJson(doc.data());
      }).toList();
    });
  }

  Future<UserModel> getNameUser({required String uid}) async {
    UserModel userTemp;
    var user = await userRef.doc(uid).snapshots().first;
    userTemp = UserModel.fromJson(user.data());
    return userTemp;
  }

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.toNamed(Routes.login);
    } catch (_) {
      return UnknownRoute();
    }
  }

  selectImgDialog(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Image form camera'),
                  onTap: () => _selectImage(context, type: ImageSource.camera)),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Image from gallery'),
                onTap: () => _selectImage(context, type: ImageSource.gallery),
              ),
            ],
          );
        });
  }

  _selectImage(context, {required ImageSource type}) async {
    PickedFile? image = await ImagePicker.platform.pickImage(source: type);
    if (image!.path != "") {
      dynamic uploud =
          await _uploadImage(folderName: "user", imagePath: image.path);
      userRef.doc(auth.currentUser!.uid).update({
        "photo": uploud,
      });

      Get.toNamed(Routes.home);
      showAlertDialog(context,
          title: "Done Successfully",
          message: "Profile Update",
          showBtnOne: false, actionBtnTwo: () {
        Get.back();
      });
    }
  }

  Future<String> _uploadImage(
      {required String folderName, required String imagePath}) async {
    UploadTask uploadTask = storageRef
        .child('$folderName/${const Uuid().v4()}')
        .putFile(io.File(imagePath));
    String url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }
}
