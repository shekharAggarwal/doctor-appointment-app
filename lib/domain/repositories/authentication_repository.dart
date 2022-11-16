import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/entities/user_entity.dart';

import '../entities/login_entity.dart';
import '../entities/login_param.dart';

abstract class AuthenticationRepository {
  Future<Either<AppError, LoginEntity>> loginUser(
      String email, String password);

  Future<Either<AppError, UserEntity>> registerUser(
      String name,
      String aadhaarNumber,
      String address,
      String dob,
      String gender,
      String bloodGroup,
      String weight,
      String height,
      String insuranceNumber,
      String? heartProblem,
      String? allergy,
      String email,
      String password);

  Future<Either<AppError, LoginParam>> checkLogin();

  Future<Either<AppError, UserEntity>> getUser(String email);

  Future<Either<AppError, DoctorEntity>> registerDoctor(String name,
      String specialization, String address, String email, String password);

  Future<Either<AppError, void>> removeLogin();

  Future<Either<AppError, void>> saveLogin(LoginParam loginParam);
}
