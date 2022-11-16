import 'package:doctor_appointment/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
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

  const UserModel(
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
      required this.email})
      : super(
            uid: uid,
            name: name,
            aadhaarNumber: aadhaarNumber,
            address: address,
            dob: dob,
            gender: gender,
            bloodGroup: bloodGroup,
            weight: weight,
            height: height,
            insuranceNumber: insuranceNumber,
            heartProblem: heartProblem,
            allergy: allergy,
            email: email);

  factory UserModel.fromJson(Map<String, dynamic> json, String uid) {
    return UserModel(
      name: json['name'],
      uid: uid,
      dob: json['dob'],
      aadhaarNumber: json['aadhaarNumber'],
      address: json['address'],
      gender: json['gender'],
      bloodGroup: json['bloodGroup'],
      weight: json['weight'],
      height: json['height'],
      insuranceNumber: json['insuranceNumber'],
      heartProblem: json['heartProblem'] ?? '',
      allergy: json['heartProblem'] ?? '',
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'uid': uid,
      'name': name,
      'dob': dob,
      'aadhaarNumber': aadhaarNumber,
      'address': address,
      'gender': gender,
      'bloodGroup': bloodGroup,
      'weight': weight,
      'height': height,
      'insuranceNumber': insuranceNumber,
      'heartProblem': heartProblem,
      'allergy': heartProblem,
      'email': email,
    };

    return data;
  }
}
