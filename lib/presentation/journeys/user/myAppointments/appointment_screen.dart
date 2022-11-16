import 'package:doctor_appointment/presentation/journeys/user/myAppointments/completed_appointment.dart';
import 'package:doctor_appointment/presentation/journeys/user/myAppointments/pendingAppointment/pending_appointment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../domain/entities/login_entity.dart';

class AppointmentScreen extends StatefulWidget {
  final LoginEntity loginEntity;

  const AppointmentScreen({Key? key, required this.loginEntity})
      : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'My Appointments',
            style: GoogleFonts.lato(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Complete',
              ),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: PendingAppointment(
                loginEntity: widget.loginEntity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: CompletedAppointment(
                loginEntity: widget.loginEntity,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
