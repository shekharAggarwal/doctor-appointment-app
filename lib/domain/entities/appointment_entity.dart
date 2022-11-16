import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AppointmentEntity extends Equatable {
  final String docId;
  final String userEmail;
  final String docEmail;
  final String docName;
  final String date;
  final String time;
  final String userId;
  final String name;
  final int isAccepted;
  final DateTime dateTime;
  final String prescriptionsId;

  const AppointmentEntity(
      {required this.userEmail,
      required this.docId,
      required this.docEmail,
      required this.docName,
      required this.date,
      required this.time,
      required this.userId,
      required this.name,
      required this.isAccepted,
      required this.dateTime,
      required this.prescriptionsId});

  @override
  List<Object?> get props => [docId, userEmail, docEmail];
}
