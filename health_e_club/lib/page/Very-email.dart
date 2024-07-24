import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';


class vieryemail extends StatefulWidget {
  const vieryemail({Key? key}) : super(key: key);

  @override
  State<vieryemail> createState() => _vieryemailState();
}

class _vieryemailState extends State<vieryemail> {
  @override
  late Timer _timer;
  final Firebase = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final Firebase = FirebaseAuth.instance.currentUser;
      if (Firebase?.emailVerified ?? true) {
        timer.cancel();
        Get.toNamed(Routes.home);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }


  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffD9D9D9),
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.verified,
                    size: 150,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Verify your email',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 100),
                  Text(
                    'Email: ${Firebase!.email} ''(verified: ${Firebase!.emailVerified})'
                  ),
                ],
              ),
            )
        )
    );
  }
}