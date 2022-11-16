import 'package:equatable/equatable.dart';

class UserRoleEntity extends Equatable {
  final String role;
  final bool isApproved;

  const UserRoleEntity({required this.role, required this.isApproved});

  @override
  List<Object?> get props => [role];
}
