import 'package:equatable/equatable.dart';

class PrescriptionParam extends Equatable {
  final String userEmail;
  final String? docEmail;
  final DateTime visitDate;
  final String reasonForVisit;
  final String symptoms;
  final String prescription;

  const PrescriptionParam(this.userEmail, this.docEmail, this.visitDate,
      this.reasonForVisit, this.symptoms, this.prescription);

  @override
  List<Object> get props => [userEmail];
}
