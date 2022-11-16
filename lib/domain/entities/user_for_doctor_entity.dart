import 'package:doctor_appointment/domain/entities/prescription_entity.dart';
import 'package:doctor_appointment/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class UserForDoctorEntity extends Equatable {
  final UserEntity user;
  final List<PrescriptionEntity> prescriptions;

  const UserForDoctorEntity({
    required this.user,
    required this.prescriptions,
  });

  @override
  List<Object?> get props => [user];
}
