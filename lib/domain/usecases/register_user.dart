import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/user_entity.dart';
import 'package:doctor_appointment/domain/entities/user_register_param.dart';
import 'package:doctor_appointment/domain/repositories/authentication_repository.dart';

import 'usecase.dart';

class RegisterUser extends UseCase<UserEntity, UserRegisterParam> {
  final AuthenticationRepository authenticationRepository;

  RegisterUser(this.authenticationRepository);

  @override
  Future<Either<AppError, UserEntity>> call(UserRegisterParam params) async {
    return await authenticationRepository.registerUser(
        params.name,
        params.aadhaarNumber,
        params.address,
        params.dob,
        params.gender,
        params.bloodGroup,
        params.weight,
        params.height,
        params.insuranceNumber,
        params.heartProblem,
        params.allergy,
        params.email,
        params.password);
  }
}
