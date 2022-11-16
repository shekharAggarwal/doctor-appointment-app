import 'package:equatable/equatable.dart';

class AppointmentParam extends Equatable {
  final String userEmail;
  final String docEmail;
  final String docName;
  final String date;
  final String time;
  final String userId;
  final String name;
  final String dateTime;
  final String timeOfDay;

  const AppointmentParam(
      {required this.userEmail,
      required this.docEmail,
      required this.docName,
      required this.date,
      required this.time,
      required this.userId,
      required this.name,
      required this.dateTime,
      required this.timeOfDay});

  @override
  List<Object> get props => [userEmail, docEmail];
}
