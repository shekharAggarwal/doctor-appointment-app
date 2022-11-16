import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class CancelAppointment extends UseCase<bool, String> {
  final AppRepository appRepository;

  CancelAppointment(this.appRepository);

  @override
  Future<Either<AppError, bool>> call(String params) async {
    return await appRepository.cancelAppointment(params);
  }
}
