import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:doctor_appointment/domain/entities/prescription_entity.dart';
import 'package:doctor_appointment/presentation/journeys/doctor/appointmentView/appointment_view.dart';
import 'package:doctor_appointment/presentation/journeys/doctor/doctorHomeScreen/doctor_main_page.dart';
import 'package:doctor_appointment/presentation/journeys/user/diseaseCheck/disease_check.dart';
import 'package:doctor_appointment/presentation/journeys/user/diseaseCheck/heartCheck/heart_check.dart';
import 'package:doctor_appointment/presentation/journeys/user/diseaseCheck/lungCheck/lung_check.dart';
import 'package:doctor_appointment/presentation/journeys/user/searchScreen/search_arg.dart';
import 'package:doctor_appointment/presentation/journeys/user/userHomeScreen/explore_arg.dart';
import 'package:flutter/material.dart';

import '../domain/entities/login_entity.dart';
import 'journeys/admin/adminHomeScreen/admin_main_page.dart';
import 'journeys/authScreen/auth_screen.dart';
import 'journeys/doctor/appointmentView/appointment_doctor_arguments.dart';
import 'journeys/doctor/doctorRegisterScreen/doctor_register_screen.dart';
import 'journeys/doctor/userProfileToDoctor/user_profile_arguments.dart';
import 'journeys/doctor/userProfileToDoctor/user_profile_to_doctor.dart';
import 'journeys/loginScreen/login_screen.dart';
import 'journeys/skipScreen/skip_screen.dart';
import 'journeys/splashScreen/splash_screen.dart';
import 'journeys/user/doctorAppointment/doctor_appointment.dart';
import 'journeys/user/doctorAppointment/doctor_arguments.dart';
import 'journeys/user/searchScreen/search_screen.dart';
import 'journeys/user/userHomeScreen/explore_list.dart';
import 'journeys/user/userHomeScreen/main_page.dart';
import 'journeys/user/userProfile/prescription/add_prescription_screen.dart';
import 'journeys/user/userProfile/prescription/view_old_prescription.dart';
import 'journeys/user/userRegisterScreen/user_register_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => const SplashScreen(),
        RouteList.skipScreen: (context) => const SkipScreen(),
        RouteList.authScreen: (context) => const AuthScreen(),
        RouteList.loginScreen: (context) => const LoginScreen(),
        RouteList.userRegisterScreen: (context) => const UserRegisterScreen(),
        RouteList.userHomeScreen: (context) => MainPage(
              loginEntity: setting.arguments as LoginEntity,
            ),
        RouteList.userAddPrescription: (context) => AddPrescriptionScreen(
              email: setting.arguments as String,
            ),
        RouteList.userViewPrescription: (context) => ViewOldPrescription(
              prescriptionEntity: setting.arguments as PrescriptionEntity,
            ),
        RouteList.userDoctorAppointmentScreen: (context) => DoctorAppointment(
            doctorArguments: setting.arguments as DoctorArguments),
        RouteList.searchDoctor: (context) => SearchScreen(
              searchArg: setting.arguments as SearchArg,
            ),
        RouteList.userDoctorByTypeScreen: (context) => ExploreList(
              exploreArg: setting.arguments as ExploreArg,
            ),
        RouteList.userCheckDisease: (context) => const DiseaseCheck(),
        RouteList.userLungDisease: (context) => const LungCheck(),
        RouteList.userHeartDisease: (context) => const HeartCheck(),

        //doctor
        RouteList.doctorRegisterScreen: (context) =>
            const DoctorRegisterScreen(),
        RouteList.doctorHomeScreen: (context) => DoctorMainPage(loginEntity: setting.arguments as LoginEntity,),

        RouteList.doctorUserScreen: (context) => UserProfileToDoctor(
              profileArguments: setting.arguments as UserProfileArguments,
            ),
        RouteList.doctorAppointmentView: (context) => AppointmentView(
              profileArguments: setting.arguments as AppointmentDoctorArguments,
            ),
        //admin
        RouteList.adminHomeScreen: (context) => AdminMainPage(
              loginEntity: setting.arguments as LoginEntity,
            ),
      };
}
