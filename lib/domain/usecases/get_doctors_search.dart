import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/repositories/app_repository.dart';
import 'package:doctor_appointment/domain/usecases/usecase.dart';

class GetDoctorsSearch extends UseCase<List<DoctorEntity>, String> {
  final AppRepository appRepository;

  GetDoctorsSearch(this.appRepository);

  @override
  Future<Either<AppError, List<DoctorEntity>>> call(String params) async {
    return await appRepository.getDoctorsSearch(params);
  }
}
