import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/no_params.dart';
import 'package:doctor_appointment/domain/repositories/authentication_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class RemoveLogin extends UseCase<void, NoParams> {
  final AuthenticationRepository authenticationRepository;

  RemoveLogin(this.authenticationRepository);

  @override
  Future<Either<AppError, void>> call(NoParams params) async {
    return authenticationRepository.removeLogin();
  }
}
