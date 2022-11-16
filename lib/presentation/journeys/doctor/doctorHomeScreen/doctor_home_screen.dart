import 'package:doctor_appointment/domain/entities/login_entity.dart';
import 'package:doctor_appointment/presentation/journeys/doctor/doctorHomeScreen/requestAppointment/request_appointment_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'todayAppointment/today_appointment_list.dart';

class DoctorHomeScreen extends StatefulWidget {
  final LoginEntity loginEntity;

  const DoctorHomeScreen({Key? key, required this.loginEntity})
      : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  late String _message;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String _currentHour = DateFormat('kk').format(now);
    int hour = int.parse(_currentHour);

    setState(
      () {
        if (hour >= 5 && hour < 12) {
          _message = 'Good Morning';
        } else if (hour >= 12 && hour <= 17) {
          _message = 'Good Afternoon';
        } else {
          _message = 'Good Evening';
        }
      },
    );
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            _message,
            style: GoogleFonts.lato(
              color: Colors.black54,
              fontSize: 20,
              fontWeight: FontWeight.w400,
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
                text: 'Request',
              ),
            ],
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: TodayAppointmentList(
                loginEntity: widget.loginEntity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: RequestAppointmentList(
                loginEntity: widget.loginEntity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
