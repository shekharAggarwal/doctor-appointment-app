import 'package:doctor_appointment/data/models/admin_model.dart';
import 'package:doctor_appointment/data/models/doctor_model.dart';
import 'package:doctor_appointment/data/models/user_model.dart';
import 'package:doctor_appointment/data/models/user_role_model.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  final DoctorModel? doctorModel;
  final UserModel? userModel;
  final AdminModel? adminModel;
  final UserRoleModel roleModel;

  const LoginModel(
      {this.doctorModel,
      this.userModel,
      this.adminModel,
      required this.roleModel})
      : super(
            doctorEntity: doctorModel,
            userEntity: userModel,
            adminEntity: adminModel,
            roleEntity: roleModel);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    try{
      if (json["role"] == "user") {
        return LoginModel(
            userModel: UserModel.fromJson(
                json["userTable"], json["userTable"]["id"].toString()),
            roleModel: UserRoleModel(
                role: json["role"], isApproved: json["userTable"]["status"]));
      } else if (json["role"] == "doctor") {
        return LoginModel(
            doctorModel: DoctorModel.fromJson(
                json["doctorTable"], json["doctorTable"]["id"].toString()),
            roleModel: UserRoleModel(
                role: json["role"], isApproved: json["doctorTable"]["accepted"]));
      } else {
        return LoginModel(
            adminModel: AdminModel.fromJson(json["adminTable"]),
            roleModel: UserRoleModel(role: json["role"], isApproved: true));
      }
    }catch(e){
      rethrow;
    }
  }
}
