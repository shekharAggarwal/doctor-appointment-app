import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:doctor_appointment/domain/usecases/cancel_appointment.dart';
import 'package:doctor_appointment/domain/usecases/get_appointment.dart';
import 'package:doctor_appointment/presentation/journeys/user/myAppointments/pendingAppointment/pending_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../domain/entities/get_appointment_params.dart';
import '../../../../../domain/entities/login_entity.dart';

class PendingAppointment extends StatefulWidget {
  final LoginEntity loginEntity;

  const PendingAppointment({Key? key, required this.loginEntity})
      : super(key: key);

  @override
  _PendingAppointmentState createState() => _PendingAppointmentState();
}

class _PendingAppointmentState extends State<PendingAppointment> {
  bool isError = false;
  bool isLoading = true;
  late GetAppointment getPendingAppointment;
  late CancelAppointment cancelAppointment;

  List<AppointmentEntity> appointments = List.empty(growable: true);

  bool _checkDiff(DateTime _date) {
    var diff = DateTime.now().difference(_date).inHours;
    if (diff >= 2) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getPendingAppointment = getItInstance<GetAppointment>();
    cancelAppointment = getItInstance<CancelAppointment>();
    _getAppointment();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : appointments.isEmpty && !isError
              ? Center(
                  child: Text(
                    'No Appointment Scheduled',
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                )
              : !isError
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        return PendingCard(
                            cancelled: () {
                              appointments.removeAt(index);
                              setState(() {});
                            },
                            appointment: appointments[index]);
                      },
                    )
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
    final appointment = await getPendingAppointment(
        GetAppointmentParams(widget.loginEntity.userEntity!.email, true));
    appointment.fold((l) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isError = true;
          isLoading = false;
        });
      });
    }, (r) {
      for (final element in r) {
        if (element.isAccepted == 0 && _checkDiff(element.dateTime)) {
          cancelAppointment(element.docId);
        } else {
          appointments.add(element);
        }
      }
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isError = false;
          isLoading = false;
        });
      });
    });
  }
}
