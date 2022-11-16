import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:doctor_appointment/domain/entities/get_appointment_params.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class GetAppointment
    extends UseCase<List<AppointmentEntity>, GetAppointmentParams> {
  final AppRepository appRepository;

  GetAppointment(this.appRepository);

  @override
  Future<Either<AppError, List<AppointmentEntity>>> call(
      GetAppointmentParams params) async {
    return await appRepository.getAppointment(
        params.userEmail, params.isPending);
  }
}
