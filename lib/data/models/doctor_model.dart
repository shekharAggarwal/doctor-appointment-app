import 'package:doctor_appointment/domain/entities/doctor_entity.dart';

class DoctorModel extends DoctorEntity {
  final String name;
  final String specialization;
  final String address;
  final String email;
  final String image;
  final String uid;

  const DoctorModel(
      {required this.name,
      required this.uid,
      required this.specialization,
      required this.address,
      required this.image,
      required this.email})
      : super(
            uid: uid,
            name: name,
            address: address,
            specialization: specialization,
            image: image,
            email: email);

  factory DoctorModel.fromJson(Map<String, dynamic> json, String uid) {
    return DoctorModel(
      uid: uid,
      name: json['name'],
      address: json['address'],
      specialization: json['degree'],
      email: json['email'],
      image:
          'https://images.unsplash.com/photo-1615665071170-3cafd93531f5?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1050&q=80',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'uid': uid,
      'name': name,
      'type': specialization,
      'address': address,
      'email': email,
      'image': image
    };

    return data;
  }
}
