import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

import '../entities/user_admin_param.dart';

class UpdateUserByAdmin extends UseCase<bool, UserAdminParam> {
  final AppRepository appRepository;

  UpdateUserByAdmin(this.appRepository);

  @override
  Future<Either<AppError, bool>> call(UserAdminParam params) async {
    return await appRepository.updateUser(params.email, params.isApproved);
  }
}
