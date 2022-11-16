import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/prescription_param.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class AddPrescription extends UseCase<bool, PrescriptionParam> {
  final AppRepository appRepository;

  AddPrescription(this.appRepository);

  @override
  Future<Either<AppError, bool>> call(PrescriptionParam params) async {
    return await appRepository.addPrescription(
        params.userEmail,
        params.docEmail,
        params.visitDate,
        params.reasonForVisit,
        params.symptoms,
        params.prescription);
  }
}
