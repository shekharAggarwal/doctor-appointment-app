import 'package:doctor_appointment/domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  final String userEmail;
  final String docId;
  final String docEmail;
  final String docName;
  final String date;
  final String time;
  final String userId;
  final String name;
  final int isAccepted;
  final DateTime dateTime;
  final String prescriptionsId;

  const AppointmentModel(
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
      required this.prescriptionsId})
      : super(
            docId: docId,
            userEmail: userEmail,
            docEmail: docEmail,
            docName: docName,
            date: date,
            time: time,
            userId: userId,
            name: name,
            isAccepted: isAccepted,
            dateTime: dateTime,
            prescriptionsId: prescriptionsId);

  factory AppointmentModel.fromJson(Map<String, dynamic> json, String key) {
    return AppointmentModel(
      date: json['appointmentTime'],
      docEmail: json['doctorEmail'],
      time: json['appointmentTime'],
      userEmail: json['userEmail'],
      isAccepted: json['isAccepted'],
      name: json['userName'],
      userId: json['userId'],
      dateTime: DateTime.parse(json['appointmentTime'].toString()),
      docName: json['doctorName'],
      prescriptionsId: json['prescriptionId'] ?? "",
      docId: key,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'date': date,
      'docEmail': docEmail,
      'time': time,
      'userEmail': userEmail,
      'isAccepted': isAccepted,
      'name': name,
      'userId': userId,
      'dateTime': dateTime,
      'docName': docName,
      'prescriptionsId': prescriptionsId,
      'docId': docId
    };

    return data;
  }
}
