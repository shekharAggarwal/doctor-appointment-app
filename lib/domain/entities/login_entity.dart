import 'package:doctor_appointment/domain/entities/admin_entity.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/entities/user_entity.dart';
import 'package:doctor_appointment/domain/entities/user_role_entity.dart';
import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final DoctorEntity? doctorEntity;
  final UserEntity? userEntity;
  final AdminEntity? adminEntity;
  final UserRoleEntity roleEntity;

  const LoginEntity(
      {this.doctorEntity,
      this.userEntity,
      this.adminEntity,
      required this.roleEntity});

  @override
  List<Object?> get props => [roleEntity];
}
