import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/user_doctor_param.dart';
import 'package:doctor_appointment/domain/entities/user_for_doctor_entity.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class GetUserForDoctor extends UseCase<UserForDoctorEntity, UserDoctorParam> {
  final AppRepository authenticationRepository;

  GetUserForDoctor(this.authenticationRepository);

  @override
  Future<Either<AppError, UserForDoctorEntity>> call(
      UserDoctorParam params) async {
    return await authenticationRepository.getUserForDoctor(
        params.userEmail, params.uid);
  }
}
