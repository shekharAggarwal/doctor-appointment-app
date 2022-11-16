import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';
import 'package:doctor_appointment/presentation/journeys/doctor/userProfileToDoctor/user_profile_arguments.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TodayAppointmentCard extends StatelessWidget {
  final AppointmentEntity appointmentEntity;
  final LoginEntity loginEntity;

  const TodayAppointmentCard(
      {Key? key, required this.appointmentEntity, required this.loginEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteList.doctorUserScreen,
            arguments: UserProfileArguments(appointmentEntity, loginEntity));
      },
      child: SizedBox(
        height: 120,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  appointmentEntity.name,
                  style: GoogleFonts.lato(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  appointmentEntity.userEmail,
                  style: GoogleFonts.lato(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(appointmentEntity.dateTime) +
                      " " +
                      DateFormat.jm().format(appointmentEntity.dateTime),
                  style: GoogleFonts.lato(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  appointmentEntity.docId,
                  style: GoogleFonts.lato(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
