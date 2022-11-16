import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/no_params.dart';
import 'package:doctor_appointment/domain/entities/user_entity.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class GetBlockedUserForAdmin extends UseCase<List<UserEntity>, NoParams> {
  final AppRepository appRepository;

  GetBlockedUserForAdmin(this.appRepository);

  @override
  Future<Either<AppError, List<UserEntity>>> call(NoParams params) async {
    return await appRepository.getBlockedUserForAdmin();
  }
}
