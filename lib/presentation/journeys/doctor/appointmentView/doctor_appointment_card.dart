import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentCard extends StatelessWidget {
  final AppointmentEntity appointmentEntity;

  const DoctorAppointmentCard({Key? key, required this.appointmentEntity})
      : super(key: key);

  Widget _view(BuildContext context, String title, String? value) {
    List<String> texts = List.empty(growable: true);
    if (value != null && value.isNotEmpty) texts = value.split(',');
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.height,
            minHeight: MediaQuery.of(context).size.height / 14,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (value != null && value.isNotEmpty)
                  Column(
                    children: texts
                        .map((e) => Text(
                              e,
                              style: GoogleFonts.lato(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                        .toList(),
                  )
                else
                  Text(
                    "Not Added",
                    style: GoogleFonts.lato(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _view(
              context,
              "Appointment Date",
              DateFormat('dd/MM/yyyy')
                      .format(appointmentEntity.dateTime) +
                  " " +
                  DateFormat.jm().format(appointmentEntity.dateTime)),
          _view(context, "User Email", appointmentEntity.userEmail),
          _view(context, "User Name", appointmentEntity.name),
        ],
      ),
    );
  }
}
