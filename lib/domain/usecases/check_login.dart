import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/login_param.dart';
import 'package:doctor_appointment/domain/entities/no_params.dart';
import 'package:doctor_appointment/domain/repositories/authentication_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class CheckLogin extends UseCase<LoginParam, NoParams> {
  final AuthenticationRepository authenticationRepository;

  CheckLogin(this.authenticationRepository);

  @override
  Future<Either<AppError, LoginParam>> call(NoParams params) async {
    return await authenticationRepository.checkLogin();
  }
}
