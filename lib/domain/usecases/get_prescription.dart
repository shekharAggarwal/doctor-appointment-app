import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/prescription_entity.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class GetPrescription extends UseCase<PrescriptionEntity, String> {
  final AppRepository appRepository;

  GetPrescription(this.appRepository);

  @override
  Future<Either<AppError, PrescriptionEntity>> call(String params) async {
    return await appRepository.getPrescription(params);
  }
}
