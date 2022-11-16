import 'package:doctor_appointment/domain/entities/login_param.dart';
import 'package:hive/hive.dart';

part 'login_table.g.dart';

@HiveType(typeId: 0)
class LoginTable extends LoginParam {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  const LoginTable(
      {required this.id, required this.email, required this.password})
      : super(email, password);
}
