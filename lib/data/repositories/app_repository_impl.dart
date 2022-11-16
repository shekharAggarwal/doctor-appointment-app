import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/data/core/no_doctor_exist_exception.dart';
import 'package:doctor_appointment/data/data_sources/app_remote_data_source.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/entities/user_entity.dart';
import 'package:doctor_appointment/domain/entities/user_for_doctor_entity.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';

import '../../domain/entities/prescription_entity.dart';

class AppRepositoryImpl extends AppRepository {
  final AppRemoteDataSource _appRemoteDataSource;

  AppRepositoryImpl(this._appRemoteDataSource);

  @override
  Future<Either<AppError, List<DoctorEntity>>> getDoctors() async {
    try {
      final docs = await _appRemoteDataSource.getDoctors();
      return Right(docs);
    } on NoDoctorExistException {
      return const Left(AppError(AppErrorType.doctorsNotExist));
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<DoctorEntity>>> getDoctorsByType(
      String type) async {
    try {
      final docs = await _appRemoteDataSource.getDoctorsByType(type);
      return Right(docs);
    } on NoDoctorExistException {
      return const Left(AppError(AppErrorType.doctorsNotExist));
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> addAppointment(
      String userEmail,
      String docEmail,
      String docName,
      String userId,
      String date,
      String time,
      String name,
      String dateTime,
      String timeOfDay) async {
    try {
      final isDone = await _appRemoteDataSource.addAppointment(userEmail,
          docEmail, docName, userId, date, time, name, dateTime, timeOfDay);
      return Right(isDone);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<DoctorEntity>>> getDoctorsSearch(
      String name) async {
    try {
      final docs = await _appRemoteDataSource.getDoctorsSearch(name);
      return Right(docs);
    } on NoDoctorExistException {
      return const Left(AppError(AppErrorType.doctorsNotExist));
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<AppointmentEntity>>> getAppointment(
      String email, bool isPending) async {
    try {
      final appointments =
          await _appRemoteDataSource.getAppointment(email, isPending);
      return Right(appointments);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> cancelAppointment(String id) async {
    try {
      final appointment = await _appRemoteDataSource.cancelAppointment(id);
      return Right(appointment);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> addPrescription(
      String userEmail,
      String? docEmail,
      DateTime visitDate,
      String reasonForVisit,
      String symptoms,
      String prescription) async {
    try {
      final isDone = await _appRemoteDataSource.addPrescription(userEmail,
          docEmail, visitDate, reasonForVisit, symptoms, prescription);
      return Right(isDone);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<PrescriptionEntity>>> getUserPrescription(
      String email) async {
    try {
      final prescriptions =
          await _appRemoteDataSource.getUserPrescription(email);
      return Right(prescriptions);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<AppointmentEntity>>>
      getDoctorCompletedAppointment(String email) async {
    try {
      final appointments =
          await _appRemoteDataSource.getDoctorCompletedAppointment(email);
      return Right(appointments);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<AppointmentEntity>>> getDoctorRequestAppointment(
      String email) async {
    try {
      final appointments =
          await _appRemoteDataSource.getDoctorRequestAppointment(email);
      return Right(appointments);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<AppointmentEntity>>> getDoctorTodayAppointment(
      String email) async {
    try {
      final appointments =
          await _appRemoteDataSource.getDoctorTodayAppointment(email);
      return Right(appointments);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> updateAppointment(String userEmail, String id,
      int status, String doctorName, DateTime timestamp) async {
    try {
      final appointment = await _appRemoteDataSource.updateAppointment(
          userEmail, id, status, doctorName, timestamp);
      return Right(appointment);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, UserForDoctorEntity>> getUserForDoctor(
      String userEmail, String uid) async {
    try {
      final user = await _appRemoteDataSource.getUserForDoctor(userEmail, uid);
      return Right(user);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> addPrescriptionByDoctor(
      String userEmail,
      String appointmentId,
      String docEmail,
      DateTime visitDate,
      String reasonForVisit,
      String symptoms,
      String prescription) async {
    try {
      final user = await _appRemoteDataSource.addPrescriptionByDoctor(
          userEmail,
          appointmentId,
          docEmail,
          visitDate,
          reasonForVisit,
          symptoms,
          prescription);
      return Right(user);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, PrescriptionEntity>> getPrescription(
      String pId) async {
    try {
      final prescription = await _appRemoteDataSource.getPrescription(pId);
      return Right(prescription);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<UserEntity>>> getBlockedUserForAdmin() async {
    try {
      final users = await _appRemoteDataSource.getBlockedUserForAdmin();
      return Right(users);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<DoctorEntity>>>
      getDoctorAcceptedForAdmin() async {
    try {
      final doctors = await _appRemoteDataSource.getDoctorAcceptedForAdmin();
      return Right(doctors);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<DoctorEntity>>>
      getDoctorRejectedForAdmin() async {
    try {
      final doctors = await _appRemoteDataSource.getDoctorRejectedForAdmin();
      return Right(doctors);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<DoctorEntity>>>
      getDoctorRequestForAdmin() async {
    try {
      final doctors = await _appRemoteDataSource.getDoctorRequestForAdmin();
      return Right(doctors);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<UserEntity>>> getUserForAdmin() async {
    try {
      final users = await _appRemoteDataSource.getUserForAdmin();
      return Right(users);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> updateDoctor(
      String email, bool isApproved) async {
    try {
      final doctor = await _appRemoteDataSource.updateDoctor(email, isApproved);
      return Right(doctor);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> updateUser(
      String email, bool isApproved) async {
    try {
      final user = await _appRemoteDataSource.updateUser(
        email,
        isApproved,
      );
      return Right(user);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> addToken(String email, String token) async {
    try {
      final tokenRes = await _appRemoteDataSource.addToken(
        email,
        token,
      );
      return Right(tokenRes);
    } catch (e) {
      return const Left(AppError(AppErrorType.network));
    }
  }
}
