import 'package:equatable/equatable.dart';

class AppointmentRequestParam extends Equatable {
  final String appointmentId;
  final String userEmail;
  final int status;
  final String doctorName;
  final DateTime timestamp;

  const AppointmentRequestParam({
    required this.userEmail,
    required this.appointmentId,
    required this.status,
    required this.doctorName,
    required this.timestamp,
  });

  @override
  List<Object> get props => [appointmentId, status];
}
