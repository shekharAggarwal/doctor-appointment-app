import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RequestAppointmentCard extends StatefulWidget {
  final AppointmentEntity appointmentEntity;
  final VoidCallback cancel;
  final VoidCallback accept;

  const RequestAppointmentCard(
      {Key? key,
      required this.appointmentEntity,
      required this.cancel,
      required this.accept})
      : super(key: key);

  @override
  State<RequestAppointmentCard> createState() => _RequestAppointmentCardState();
}

class _RequestAppointmentCardState extends State<RequestAppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text(
                      widget.appointmentEntity.name,
                      style: GoogleFonts.lato(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      widget.appointmentEntity.userEmail,
                      style: GoogleFonts.lato(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(
                              widget.appointmentEntity.dateTime) +
                          " " +
                          DateFormat.jm().format(
                              widget.appointmentEntity.dateTime),
                      style: GoogleFonts.lato(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          widget.cancel();
                        },
                        child: const Center(
                          child: Icon(
                            Icons.clear_rounded,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          widget.accept();
                        },
                        child: const Center(
                          child: Icon(
                            Icons.check_rounded,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
