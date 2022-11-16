import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PrescriptionEntity extends Equatable {
  final String prescriptionId;
  final String userEmail;
  final String docEmail;
  final DateTime visitDate;
  final String reasonForVisit;
  final String symptoms;
  final String prescription;

  const PrescriptionEntity(
      {required this.userEmail,
      required this.prescriptionId,
      required this.docEmail,
      required this.visitDate,
      required this.reasonForVisit,
      required this.symptoms,
      required this.prescription});

  @override
  List<Object?> get props => [prescriptionId];
}
