import 'package:doctor_appointment/data/models/prescription_model.dart';
import 'package:doctor_appointment/data/models/user_model.dart';
import 'package:doctor_appointment/domain/entities/user_for_doctor_entity.dart';

class UserForDoctorModel extends UserForDoctorEntity {
  final UserModel user;
  final List<PrescriptionModel> prescriptions;

  const UserForDoctorModel({required this.user, required this.prescriptions})
      : super(user: user, prescriptions: prescriptions);
}
