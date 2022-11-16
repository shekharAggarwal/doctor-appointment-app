import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/token_params.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class AddToken extends UseCase<bool, TokenParams> {
  final AppRepository appRepository;

  AddToken(this.appRepository);

  @override
  Future<Either<AppError, bool>> call(TokenParams params) {
    return appRepository.addToken(params.email, params.token);
  }
}
