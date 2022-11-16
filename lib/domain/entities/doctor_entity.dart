import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String name;
  final String specialization;
  final String address;
  final String image;
  final String email;
  final String uid;

  const DoctorEntity(
      {required this.name,
        required this.uid,
        required this.specialization,
      required this.address,
      required this.image,
      required this.email});

  @override
  List<Object?> get props => [name, specialization];
}
