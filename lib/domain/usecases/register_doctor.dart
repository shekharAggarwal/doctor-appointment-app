import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/entities/doctor_register_param.dart';
import 'package:doctor_appointment/domain/repositories/authentication_repository.dart';

import 'usecase.dart';

class RegisterDoctor extends UseCase<DoctorEntity, DoctorRegisterParam> {
  final AuthenticationRepository authenticationRepository;

  RegisterDoctor(this.authenticationRepository);

  @override
  Future<Either<AppError, DoctorEntity>> call(
      DoctorRegisterParam params) async {
    return await authenticationRepository.registerDoctor(params.name,
        params.specialization, params.address, params.email, params.password);
  }
}
