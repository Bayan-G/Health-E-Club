/*
 * Copyright (c) 2022   omnni
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_e_club/routes/Pages.dart';
import 'package:health_e_club/routes/app_routes.dart';
import 'package:health_e_club/unknown/unknown_route.dart';
import 'package:health_e_club/utils/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Binding/UnknownBinding.dart';
import 'Controller/MyApp_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

  class MyApp extends GetView<MyAppController> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health E- club',
      getPages: root.routes,
      initialRoute: root.INITIAL,
      unknownRoute: GetPage(
        name: Routes.error,
        page: () =>  UnknownRoute(),
        binding: UnknownBinding(),
      ),
    );
  }
}
