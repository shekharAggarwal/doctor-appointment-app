import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String body;
  final DateTime dateTime;

  const NotificationEntity(
      {required this.id,
      required this.title,
      required this.body,
      required this.dateTime});

  @override
  List<Object?> get props => [title, body, id];
}
