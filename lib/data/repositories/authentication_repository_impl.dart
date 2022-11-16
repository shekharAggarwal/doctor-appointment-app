import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/data/core/email_exist_exception.dart';
import 'package:doctor_appointment/data/core/not_verfied_exception.dart';
import 'package:doctor_appointment/data/data_sources/app_local_data_source.dart';
import 'package:doctor_appointment/data/data_sources/authentication_remote_data_source.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';

import '../../domain/entities/login_param.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AppLocalDataSource _localDataSource;

  AuthenticationRepositoryImpl(
      this._authenticationRemoteDataSource, this._localDataSource);

  @override
  Future<Either<AppError, LoginParam>> checkLogin() async {
    try {
      final user = await _localDataSource.getLogin();
      return Right(user);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.unauthorised));
    }
  }

  @override
  Future<Either<AppError, LoginEntity>> loginUser(
      String email, String password) async {
    try {
      final user =
          await _authenticationRemoteDataSource.loginUser(email, password);
      return Right(user);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on NotVerifiedException {
      return const Left(AppError(AppErrorType.notVerified));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
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
      String password) async {
    try {
      final user = await _authenticationRemoteDataSource.registerUser(
          name,
          aadhaarNumber,
          address,
          dob,
          gender,
          bloodGroup,
          weight,
          height,
          insuranceNumber,
          heartProblem,
          allergy,
          email,
          password);
      return Right(user);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on EmailExistException {
      return const Left(AppError(AppErrorType.userExist));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, UserEntity>> getUser(String email) async {
    try {
      final user = await _authenticationRemoteDataSource.getUser(email);
      return Right(user);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, DoctorEntity>> registerDoctor(
      String name,
      String specialization,
      String address,
      String email,
      String password) async {
    try {
      final user = await _authenticationRemoteDataSource.registerDoctor(
          name, specialization, address, email, password);
      return Right(user);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on EmailExistException {
      return const Left(AppError(AppErrorType.userExist));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> removeLogin() async {
    try {
      final lo = await _localDataSource.removeLogin();
      return Right(lo);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> saveLogin(LoginParam loginParam) async {
    try {
      final lo = await _localDataSource.saveLogin(
          loginParam.email, loginParam.password);
      return Right(lo);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }
}
