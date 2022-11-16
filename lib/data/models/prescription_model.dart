import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/domain/entities/prescription_entity.dart';

class PrescriptionModel extends PrescriptionEntity {
  final String prescriptionId;
  final String userEmail;
  final String docEmail;
  final DateTime visitDate;
  final String reasonForVisit;
  final String symptoms;
  final String prescription;

  const PrescriptionModel(
      {required this.userEmail,
      required this.prescriptionId,
      required this.docEmail,
      required this.visitDate,
      required this.reasonForVisit,
      required this.symptoms,
      required this.prescription})
      : super(
            userEmail: userEmail,
            prescriptionId: prescriptionId,
            docEmail: docEmail,
            visitDate: visitDate,
            reasonForVisit: reasonForVisit,
            symptoms: symptoms,
            prescription: prescription);

  factory PrescriptionModel.fromJson(Map<String, dynamic> json, String id) {
    return PrescriptionModel(
      userEmail: json['userEmail'],
      reasonForVisit: json['reason'],
      visitDate: DateTime.parse(json['appointmentTime'].toString()),
      prescription: json['prescription'],
      docEmail: json['doctorEmail'] ?? "",
      prescriptionId: id,
      symptoms: json['symptoms'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'userEmail': userEmail,
      'reasonForVisit': reasonForVisit,
      'visitDate': visitDate,
      'prescription': prescription,
      'docEmail': docEmail,
      'prescriptionId': prescriptionId,
      'symptoms': symptoms
    };

    return data;
  }
}
