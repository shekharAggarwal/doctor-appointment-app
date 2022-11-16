import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/appointment_request_param.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class UpdateAppointment extends UseCase<bool, AppointmentRequestParam> {
  final AppRepository appRepository;

  UpdateAppointment(this.appRepository);

  @override
  Future<Either<AppError, bool>> call(AppointmentRequestParam params) async {
    return await appRepository.updateAppointment(
        params.userEmail,
        params.appointmentId,
        params.status,
        params.doctorName,
        params.timestamp);
  }
}
