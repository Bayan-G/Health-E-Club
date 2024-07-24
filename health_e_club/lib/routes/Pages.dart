/*
 * Copyright (c) 2022   omnni
 */

import 'package:get/get.dart' show GetPage;
import 'package:health_e_club/page/wrapper.dart';
import '../Binding/Edit_or_Delete_appointment_Binding.dart';
import '../Binding/ForgetPassword_binding.dart';
import '../Binding/GroupBinding.dart';
import '../Binding/HomeBinding.dart';
import '../Binding/Insert_appointment_Binding.dart';
import '../Binding/SupportBinding.dart';
import '../Binding/book_an_appointment_binding.dart';
import '../Binding/chat_Binding.dart';
import '../Binding/diseaseBinding.dart';
import '../Binding/doctorBinding.dart';
import '../Binding/doctor_profileBinfing.dart';
import '../Binding/loginBinding.dart';
import '../Binding/WrapperBinding.dart';
import '../Binding/patient_appointment_binding.dart';
import '../Binding/profileBinding.dart';
import '../Binding/registerBinding.dart';
import '../page/Chats_live.dart';
import '../page/Choose_doctor.dart';
import '../page/Disease.dart';
import '../page/Edit_or_Delete_appointment.dart';
import '../page/ForgetPassword.dart';
import '../page/Group.dart';
import '../page/Home.dart';
import '../page/Insert_appointment.dart';
import '../page/Support.dart';
import '../page/Very-email.dart';
import '../page/book_an_appointment.dart';
import '../page/chats.dart';
import '../page/doctor_profile.dart';
import '../page/login.dart';
import '../page/patient_appointment.dart';
import '../page/profile.dart';
import '../page/register.dart';
import 'app_routes.dart';

class root {
  static const INITIAL = Routes.Wrapper;

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => loginPage(),
      binding: loginBinding(),
    ),
    GetPage(
      name: Routes.vieryemail,
      page: () => vieryemail(),
    ),
    GetPage(
      name: Routes.ForgetPassword,
      page: () => ForgetPassword(),
      binding: ForgetPassword_binding(),
    ),
    GetPage(
      name: Routes.Wrapper,
      page: () => Wrapper(),
      binding: WrapperBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => homePage(),
      binding: homeBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => registerPage(),
      binding: registerBinding(),
    ),
    GetPage(
      name: Routes.diease,
      page: () => DieasePageScreen(),
      binding: DiseaseBinding(),
    ),
    GetPage(
      name: Routes.chat,
      page: () => chat(),
      binding: chat_Binding(),
    ),
    GetPage(
      name: Routes.BookAnAppointmentScreen,
      page: () => BookAnAppointmentScreen(),
      binding: Book_An_Appointment_Binding(),
    ),
    GetPage(
      name: Routes.PatientAppointment,
      page: () => PatientAppointment(),
      binding: PatientAppointmentBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => profile(),
      binding: profileBinding(),
    ),
    GetPage(
      name: Routes.Group,
      page: () => Group(),
      binding: GroupBinding(),
    ),
    GetPage(
      name: Routes.doctor_profile,
      page: () => doctor_profile(),
      binding: doctor_profileBinfing(),
    ),
    GetPage(
      name: Routes.Choos_doctor,
      page: () => Choos_doctor(),
      binding: doctorBinding(),
    ),
    GetPage(
        name: Routes.Chats_live,
        page: () => Chats_live(),
        binding: chat_Binding()),
    GetPage(
        name: Routes.Edit_or_Delete_appointment,
        page: () => Edit_or_Delete_appointment(),
        binding: Edit_or_Delete_appointment_Binding()),
    GetPage(
        name: Routes.Insert_appointment,
        page: () => Insert_appointment(),
        binding: Insert_appointment_Binding()),
    GetPage(
        name: Routes.Support, page: () => Support(), binding: SupportBinding()),
  ];
}
