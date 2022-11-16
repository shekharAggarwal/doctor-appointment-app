import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/doctor_prescription_param.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class AddPrescriptionByDoctor extends UseCase<bool, DoctorPrescriptionParam> {
  final AppRepository appRepository;

  AddPrescriptionByDoctor(this.appRepository);

  @override
  Future<Either<AppError, bool>> call(DoctorPrescriptionParam params) async {
    return await appRepository.addPrescriptionByDoctor(
        params.userEmail,
        params.appointmentId,
        params.docEmail,
        params.visitDate,
        params.reasonForVisit,
        params.symptoms,
        params.prescription);
  }
}
