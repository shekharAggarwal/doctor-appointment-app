import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class GetDoctorRequestAppointment
    extends UseCase<List<AppointmentEntity>, String> {
  final AppRepository appRepository;

  GetDoctorRequestAppointment(this.appRepository);

  @override
  Future<Either<AppError, List<AppointmentEntity>>> call(String params) async {
    return await appRepository.getDoctorRequestAppointment(params);
  }
}
