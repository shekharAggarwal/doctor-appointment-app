import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/login_param.dart';
import 'package:doctor_appointment/domain/repositories/authentication_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

import '../entities/login_entity.dart';

class LoginUser extends UseCase<LoginEntity, LoginParam> {
  final AuthenticationRepository authenticationRepository;

  LoginUser(this.authenticationRepository);

  @override
  Future<Either<AppError, LoginEntity>> call(LoginParam params) async {
    return await authenticationRepository.loginUser(
        params.email, params.password);
  }
}
