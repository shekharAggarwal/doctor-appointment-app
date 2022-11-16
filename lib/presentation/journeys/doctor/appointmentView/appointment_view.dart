import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appointment_doctor_arguments.dart';
import 'doctor_appointment_card.dart';
import 'doctor_prescription.dart';

class AppointmentView extends StatefulWidget {
  final AppointmentDoctorArguments profileArguments;

  const AppointmentView({Key? key, required this.profileArguments})
      : super(key: key);

  @override
  _AppointmentViewState createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            splashRadius: 20,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.indigo,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Appointment Info',
          style: GoogleFonts.lato(
            color: Colors.indigo,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            DoctorAppointmentCard(
              appointmentEntity: widget.profileArguments.appointmentEntity,
            ),
            DoctorPrescription(
              pId: widget.profileArguments.appointmentEntity.docId,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
