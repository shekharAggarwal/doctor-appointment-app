import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';
import 'package:doctor_appointment/domain/usecases/get_doctor_completed_appointment.dart';
import 'package:doctor_appointment/presentation/journeys/doctor/completedAppointment/completed_appointment_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedAppointment extends StatefulWidget {
  final LoginEntity loginEntity;
  const CompletedAppointment({Key? key, required this.loginEntity}) : super(key: key);

  @override
  _CompletedAppointmentState createState() => _CompletedAppointmentState();
}

class _CompletedAppointmentState extends State<CompletedAppointment> {
  bool isLoading = true;
  bool isError = false;
  List<AppointmentEntity> appointments = List.empty(growable: true);
  late GetDoctorCompletedAppointment getDoctorAppointment;

  @override
  void initState() {
    getDoctorAppointment = getItInstance<GetDoctorCompletedAppointment>();
    _getAppointment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : appointments.isEmpty && !isError
              ? Center(
                  child: Text(
                    'No Appointment Completed yet',
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
                        return CompletedAppointmentCard(
                          appointmentEntity: appointments[index],
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
