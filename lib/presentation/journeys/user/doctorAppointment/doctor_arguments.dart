import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';

class DoctorArguments {
  final DoctorEntity doctor;
  final LoginEntity loginEntity;

  DoctorArguments(this.doctor, this.loginEntity);
}
