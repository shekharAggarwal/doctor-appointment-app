import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class GetDoctorsByType extends UseCase<List<DoctorEntity>, String> {
  final AppRepository appRepository;

  GetDoctorsByType(this.appRepository);

  @override
  Future<Either<AppError, List<DoctorEntity>>> call(String params) async {
    return await appRepository.getDoctorsByType(params);
  }
}
