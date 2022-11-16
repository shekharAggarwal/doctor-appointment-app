import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';
import 'package:doctor_appointment/domain/usecases/get_doctor_pending_appointment.dart';
import 'package:doctor_appointment/presentation/journeys/doctor/doctorHomeScreen/todayAppointment/today_appointment_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodayAppointmentList extends StatefulWidget {
  final LoginEntity loginEntity;

  const TodayAppointmentList({Key? key, required this.loginEntity})
      : super(key: key);

  @override
  State<TodayAppointmentList> createState() => _TodayAppointmentListState();
}

class _TodayAppointmentListState extends State<TodayAppointmentList> {
  bool isLoading = true;
  bool isError = false;
  List<AppointmentEntity> appointments = List.empty(growable: true);
  late GetDoctorPendingAppointment getDoctorAppointment;
  late FirebaseAuth _auth;

  @override
  void initState() {
    getDoctorAppointment = getItInstance<GetDoctorPendingAppointment>();
    _auth = getItInstance<FirebaseAuth>();
    _getAppointment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : appointments.isEmpty && !isError
              ? Center(
                  child: Text(
                    'No Appointment Today',
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                )
              : !isError
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TodayAppointmentCard(
                          appointmentEntity: appointments[index],
                          loginEntity: widget.loginEntity,
                        );
                      },
                      itemCount: appointments.length)
                  : Center(
                      child: Text(
                        'Error while getting Appointments',
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
    );
  }

  void _getAppointment() async {
    final appointmentList =
        await getDoctorAppointment(widget.loginEntity.doctorEntity!.email);
    appointmentList.fold((l) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {
          isError = true;
          isLoading = false;
        });
      });
    }, (r) {
      appointments = r;
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {
          isError = false;
          isLoading = false;
        });
      });
    });
  }
}
