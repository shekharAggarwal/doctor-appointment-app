import 'package:equatable/equatable.dart';

class UserAdminParam extends Equatable {
  final String email;
  final bool isApproved;

  const UserAdminParam({required this.email, required this.isApproved});

  @override
  List<Object> get props => [email, isApproved];
}
