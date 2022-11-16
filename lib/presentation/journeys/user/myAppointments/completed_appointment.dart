import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:doctor_appointment/domain/entities/get_appointment_params.dart';
import 'package:doctor_appointment/domain/usecases/get_appointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/login_entity.dart';

class CompletedAppointment extends StatefulWidget {
  final LoginEntity loginEntity;

  const CompletedAppointment({Key? key, required this.loginEntity})
      : super(key: key);

  @override
  _CompletedAppointmentState createState() => _CompletedAppointmentState();
}

class _CompletedAppointmentState extends State<CompletedAppointment> {
  bool isError = false;
  bool isLoading = true;
  late GetAppointment getPendingAppointment;

  List<AppointmentEntity> appointments = List.empty(growable: true);

  String _dateFormatter(String _timestamp) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(_timestamp));
    return formattedDate;
  }

  String _timeFormatter(String _timestamp) {
    String formattedTime =
        DateFormat('kk:mm').format(DateTime.parse(_timestamp));
    return formattedTime;
  }

  @override
  void initState() {
    super.initState();
    getPendingAppointment = getItInstance<GetAppointment>();
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
                        return Card(
                          elevation: 2,
                          child: InkWell(
                            onTap: () {},
                            child: ExpansionTile(
                              title: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  appointments[index].docName,
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  _dateFormatter(
                                      appointments[index].dateTime.toString()),
                                  style: GoogleFonts.lato(),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, right: 10, left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Patient name: " +
                                            appointments[index].name,
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Time: " +
                                            _timeFormatter(
                                              appointments[index]
                                                  .dateTime
                                                  .toString(),
                                            ),
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (appointments[index].isAccepted == 2)
                                        Text(
                                          "Completed",
                                          style: GoogleFonts.lato(
                                            fontSize: 16,
                                          ),
                                        )
                                      else
                                        Text(
                                          "Cancelled",
                                          style: GoogleFonts.lato(
                                            fontSize: 16,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
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
        GetAppointmentParams(widget.loginEntity.userEntity!.email, false));
    appointment.fold(
        (l) => setState(() {
              isError = true;
              isLoading = false;
            }), (r) {
      appointments = r;
      setState(() {
        isError = false;
        isLoading = false;
      });
    });
  }
}
