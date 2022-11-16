import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/no_params.dart';
import 'package:doctor_appointment/domain/entities/user_entity.dart';
import 'package:doctor_appointment/domain/repositories/authentication_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class GetUser extends UseCase<UserEntity, String> {
  final AuthenticationRepository authenticationRepository;

  GetUser(this.authenticationRepository);

  @override
  Future<Either<AppError, UserEntity>> call(String email) async {
    return await authenticationRepository.getUser(email);
  }
}
