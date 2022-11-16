import 'package:doctor_appointment/domain/entities/user_role_entity.dart';

class UserRoleModel extends UserRoleEntity {
  final String role;
  final bool isApproved;

  const UserRoleModel({required this.role, required this.isApproved})
      : super(role: role, isApproved: isApproved);

  factory UserRoleModel.fromJson(Map<String, dynamic> json) {
    return UserRoleModel(
        role: json["role"], isApproved: json["isApproved"] ?? false);
  }
}
