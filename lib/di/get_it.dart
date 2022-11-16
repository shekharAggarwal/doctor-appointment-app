import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/data/core/api_client.dart';
import 'package:doctor_appointment/data/data_sources/app_local_data_source.dart';
import 'package:doctor_appointment/data/data_sources/app_remote_data_source.dart';
import 'package:doctor_appointment/data/data_sources/authentication_remote_data_source.dart';
import 'package:doctor_appointment/data/repositories/app_repository_impl.dart';
import 'package:doctor_appointment/data/repositories/authentication_repository_impl.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/repositories/authentication_repository.dart';
import 'package:doctor_appointment/domain/usecases/add_appointment.dart';
import 'package:doctor_appointment/domain/usecases/add_prescription.dart';
import 'package:doctor_appointment/domain/usecases/add_prescription_by_doctor.dart';
import 'package:doctor_appointment/domain/usecases/add_token.dart';
import 'package:doctor_appointment/domain/usecases/cancel_appointment.dart';
import 'package:doctor_appointment/domain/usecases/check_login.dart';
import 'package:doctor_appointment/domain/usecases/get_appointment.dart';
import 'package:doctor_appointment/domain/usecases/get_blocked_user_for_admin.dart';
import 'package:doctor_appointment/domain/usecases/get_doctor_accepted_for_admin.dart';
import 'package:doctor_appointment/domain/usecases/get_doctor_completed_appointment.dart';
import 'package:doctor_appointment/domain/usecases/get_doctor_pending_appointment.dart';
import 'package:doctor_appointment/domain/usecases/get_doctor_request_appointment.dart';
import 'package:doctor_appointment/domain/usecases/get_doctor_request_for_admin.dart';
import 'package:doctor_appointment/domain/usecases/get_doctors.dart';
import 'package:doctor_appointment/domain/usecases/get_doctors_by_type.dart';
import 'package:doctor_appointment/domain/usecases/get_doctors_search.dart';
import 'package:doctor_appointment/domain/usecases/get_prescription.dart';
import 'package:doctor_appointment/domain/usecases/get_user.dart';
import 'package:doctor_appointment/domain/usecases/get_user_for_admin.dart';
import 'package:doctor_appointment/domain/usecases/get_user_for_doctor.dart';
import 'package:doctor_appointment/domain/usecases/get_user_prescription.dart';
import 'package:doctor_appointment/domain/usecases/login_user.dart';
import 'package:doctor_appointment/domain/usecases/register_doctor.dart';
import 'package:doctor_appointment/domain/usecases/register_user.dart';
import 'package:doctor_appointment/domain/usecases/remove_login.dart';
import 'package:doctor_appointment/domain/usecases/save_login.dart';
import 'package:doctor_appointment/domain/usecases/update_appointment.dart';
import 'package:doctor_appointment/domain/usecases/update_doctor_by_admin.dart';
import 'package:doctor_appointment/domain/usecases/update_user_by_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../domain/usecases/get_doctor_rejected_for_admin.dart';

final getItInstance = GetIt.I;

Future init() async {
  //Client
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance
      .registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getItInstance.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  //DATA SOURCE
  getItInstance.registerLazySingleton<AppRemoteDataSource>(
      () => AppRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AppLocalDataSource>(
      () => AppLocalDataSourceImpl());

  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(getItInstance()));

  //REPOSITORY
  getItInstance.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));

  //local database
  getItInstance
      .registerLazySingleton<SaveLogin>(() => SaveLogin(getItInstance()));
  //local database
  getItInstance
      .registerLazySingleton<RemoveLogin>(() => RemoveLogin(getItInstance()));
  //USE CASE
  getItInstance.registerLazySingleton<GetUser>(() => GetUser(getItInstance()));
  getItInstance
      .registerLazySingleton<AddToken>(() => AddToken(getItInstance()));
  getItInstance.registerLazySingleton<GetPrescription>(
      () => GetPrescription(getItInstance()));
  getItInstance.registerLazySingleton<AddPrescriptionByDoctor>(
      () => AddPrescriptionByDoctor(getItInstance()));
  getItInstance.registerLazySingleton<GetUserForDoctor>(
      () => GetUserForDoctor(getItInstance()));
  getItInstance.registerLazySingleton<UpdateAppointment>(
      () => UpdateAppointment(getItInstance()));
  getItInstance.registerLazySingleton<GetDoctorPendingAppointment>(
      () => GetDoctorPendingAppointment(getItInstance()));
  getItInstance.registerLazySingleton<GetDoctorCompletedAppointment>(
      () => GetDoctorCompletedAppointment(getItInstance()));
  getItInstance.registerLazySingleton<GetDoctorRequestAppointment>(
      () => GetDoctorRequestAppointment(getItInstance()));
  getItInstance.registerLazySingleton<AddPrescription>(
      () => AddPrescription(getItInstance()));
  getItInstance.registerLazySingleton<GetUserPrescription>(
      () => GetUserPrescription(getItInstance()));
  getItInstance.registerLazySingleton<CancelAppointment>(
      () => CancelAppointment(getItInstance()));
  getItInstance.registerLazySingleton<GetAppointment>(
      () => GetAppointment(getItInstance()));
  getItInstance.registerLazySingleton<GetDoctorsSearch>(
      () => GetDoctorsSearch(getItInstance()));
  getItInstance.registerLazySingleton<AddAppointment>(
      () => AddAppointment(getItInstance()));
  getItInstance.registerLazySingleton<GetDoctorsByType>(
      () => GetDoctorsByType(getItInstance()));
  getItInstance
      .registerLazySingleton<GetDoctors>(() => GetDoctors(getItInstance()));
  getItInstance.registerLazySingleton<RegisterDoctor>(
      () => RegisterDoctor(getItInstance()));
  getItInstance
      .registerLazySingleton<CheckLogin>(() => CheckLogin(getItInstance()));
  getItInstance
      .registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));
  getItInstance
      .registerLazySingleton<RegisterUser>(() => RegisterUser(getItInstance()));

  //admin
  getItInstance.registerLazySingleton<GetDoctorRequestForAdmin>(
      () => GetDoctorRequestForAdmin(getItInstance()));
  getItInstance.registerLazySingleton<GetDoctorAcceptedForAdmin>(
      () => GetDoctorAcceptedForAdmin(getItInstance()));
  getItInstance.registerLazySingleton<GetDoctorRejectedForAdmin>(
      () => GetDoctorRejectedForAdmin(getItInstance()));

  getItInstance.registerLazySingleton<GetUserForAdmin>(
      () => GetUserForAdmin(getItInstance()));

  getItInstance.registerLazySingleton<GetBlockedUserForAdmin>(
      () => GetBlockedUserForAdmin(getItInstance()));

  getItInstance.registerLazySingleton<UpdateUserByAdmin>(
      () => UpdateUserByAdmin(getItInstance()));

  getItInstance.registerLazySingleton<UpdateDoctorByAdmin>(
      () => UpdateDoctorByAdmin(getItInstance()));
}
