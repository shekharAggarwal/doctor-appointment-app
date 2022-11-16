import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/doctor_admin_param.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class UpdateDoctorByAdmin extends UseCase<bool, DoctorAdminParam> {
  final AppRepository appRepository;

  UpdateDoctorByAdmin(this.appRepository);

  @override
  Future<Either<AppError, bool>> call(DoctorAdminParam params) async {
    return await appRepository.updateDoctor(params.email, params.isApproved);
  }
}
