import 'package:equatable/equatable.dart';

class DoctorPrescriptionParam extends Equatable {
  final String userEmail;
  final String docEmail;
  final DateTime visitDate;
  final String reasonForVisit;
  final String symptoms;
  final String prescription;
  final String appointmentId;

  const DoctorPrescriptionParam(
      this.userEmail,
      this.docEmail,
      this.visitDate,
      this.reasonForVisit,
      this.symptoms,
      this.prescription,
      this.appointmentId);

  @override
  List<Object> get props => [userEmail];
}
