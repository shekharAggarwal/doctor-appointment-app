import 'package:equatable/equatable.dart';

class DoctorAdminParam extends Equatable {
  final String email;
  final bool isApproved;

  const DoctorAdminParam({
    required this.email,
    required this.isApproved,
  });

  @override
  List<Object> get props => [email, isApproved];
}
