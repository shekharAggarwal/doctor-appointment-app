import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/entities/no_params.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class GetDoctorAcceptedForAdmin extends UseCase<List<DoctorEntity>, NoParams> {
  final AppRepository appRepository;

  GetDoctorAcceptedForAdmin(this.appRepository);

  @override
  Future<Either<AppError, List<DoctorEntity>>> call(NoParams params) async {
    return await appRepository.getDoctorAcceptedForAdmin();
  }
}