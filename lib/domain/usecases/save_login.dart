import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/login_param.dart';
import 'package:doctor_appointment/domain/repositories/authentication_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class SaveLogin extends UseCase<void, LoginParam> {
  final AuthenticationRepository authenticationRepository;

  SaveLogin(this.authenticationRepository);

  @override
  Future<Either<AppError, void>> call(LoginParam params) async {
    return await authenticationRepository.saveLogin(params);
  }
}
