import 'package:equatable/equatable.dart';

class AdminEntity extends Equatable {
  final String name;
  final String email;

  const AdminEntity({required this.name, required this.email});

  @override
  List<Object?> get props => [name, email];
}
