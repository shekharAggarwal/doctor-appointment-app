import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
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
  final String uid;

  const UserEntity(
      {required this.name,
      required this.aadhaarNumber,
      required this.uid,
      required this.address,
      required this.dob,
      required this.gender,
      required this.bloodGroup,
      required this.weight,
      required this.height,
      required this.insuranceNumber,
      this.heartProblem,
      this.allergy,
      required this.email});

  @override
  List<Object?> get props => [name, email];
}
