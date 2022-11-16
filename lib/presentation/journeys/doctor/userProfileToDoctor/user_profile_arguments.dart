import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';

class UserProfileArguments {
 final AppointmentEntity appointmentEntity;
 final LoginEntity loginEntity;

 UserProfileArguments(this.appointmentEntity, this.loginEntity);
}
