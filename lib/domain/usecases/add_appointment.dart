import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/appointment_param.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class AddAppointment extends UseCase<bool, AppointmentParam> {
  final AppRepository appRepository;

  AddAppointment(this.appRepository);

  @override
  Future<Either<AppError, bool>> call(AppointmentParam params) async {
    return await appRepository.addAppointment(
        params.userEmail,
        params.docEmail,
        params.docName,
        params.userId,
        params.date,
        params.time,
        params.name,
        params.dateTime,
        params.timeOfDay);
  }
}
