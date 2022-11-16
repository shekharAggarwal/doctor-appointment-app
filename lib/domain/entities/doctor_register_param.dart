import 'package:equatable/equatable.dart';

class DoctorRegisterParam extends Equatable {
  final String name;
  final String specialization;
  final String address;
  final String email;
  final String password;

  const DoctorRegisterParam(
      this.name, this.specialization, this.address, this.email, this.password);

  @override
  List<Object> get props => [email];
}
