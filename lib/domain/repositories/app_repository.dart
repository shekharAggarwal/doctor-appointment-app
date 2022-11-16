import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/entities/user_entity.dart';
import 'package:doctor_appointment/domain/entities/user_for_doctor_entity.dart';

import '../entities/prescription_entity.dart';

abstract class AppRepository {
  Future<Either<AppError, List<DoctorEntity>>> getDoctors();

  Future<Either<AppError, bool>> cancelAppointment(String id);

  Future<Either<AppError, UserForDoctorEntity>> getUserForDoctor(
      String userEmail, String uid);

  Future<Either<AppError, bool>> updateAppointment(String userEmail, String id,
      int status, String doctorName, DateTime timestamp);

  Future<Either<AppError, List<DoctorEntity>>> getDoctorsByType(String type);

  Future<Either<AppError, List<DoctorEntity>>> getDoctorsSearch(String name);

  Future<Either<AppError, List<AppointmentEntity>>> getAppointment(
      String email, bool isPending);

  Future<Either<AppError, List<AppointmentEntity>>> getDoctorRequestAppointment(
      String email);

  Future<Either<AppError, List<AppointmentEntity>>> getDoctorTodayAppointment(
      String email);

  Future<Either<AppError, List<AppointmentEntity>>>
      getDoctorCompletedAppointment(String email);

  Future<Either<AppError, bool>> addAppointment(
      String userEmail,
      String docEmail,
      String docName,
      String userId,
      String date,
      String time,
      String name,
      String dateTime,
      String timeOfDay);

  Future<Either<AppError, bool>> addPrescription(
    String userEmail,
    String? docEmail,
    DateTime visitDate,
    String reasonForVisit,
    String symptoms,
    String prescription,
  );

  Future<Either<AppError, List<PrescriptionEntity>>> getUserPrescription(
      String email);

  Future<Either<AppError, bool>> addPrescriptionByDoctor(
    String userEmail,
    String appointmentId,
    String docEmail,
    DateTime visitDate,
    String reasonForVisit,
    String symptoms,
    String prescription,
  );

  Future<Either<AppError, PrescriptionEntity>> getPrescription(String pId);

  Future<Either<AppError, List<DoctorEntity>>> getDoctorRequestForAdmin();

  Future<Either<AppError, List<DoctorEntity>>> getDoctorAcceptedForAdmin();

  Future<Either<AppError, List<DoctorEntity>>> getDoctorRejectedForAdmin();

  Future<Either<AppError, List<UserEntity>>> getUserForAdmin();

  Future<Either<AppError, List<UserEntity>>> getBlockedUserForAdmin();

  Future<Either<AppError, bool>> updateUser(String email, bool isApproved);

  Future<Either<AppError, bool>> updateDoctor(String email, bool isApproved);

  Future<Either<AppError, bool>> addToken(String email, String token);
}
