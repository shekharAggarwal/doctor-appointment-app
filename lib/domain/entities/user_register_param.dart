import 'package:equatable/equatable.dart';

class UserRegisterParam extends Equatable {
  final String name;
  final String aadhaarNumber;
  final String address;
  final String dob;
  final String gender;
  final String bloodGroup;
  final String weight;
  final String height;
  final String insuranceNumber;
  final String? heartProblem;
  final String? allergy;
  final String email;
  final String password;

  const UserRegisterParam(
      this.name,
      this.aadhaarNumber,
      this.address,
      this.dob,
      this.gender,
      this.bloodGroup,
      this.weight,
      this.height,
      this.insuranceNumber,
      this.heartProblem,
      this.allergy,
      this.email,
      this.password);

  @override
  List<Object?> get props => [email, name];
}
