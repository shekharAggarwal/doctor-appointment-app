import 'package:doctor_appointment/common/constants/app_string.dart';
import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:doctor_appointment/domain/entities/appointment_request_param.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';
import 'package:doctor_appointment/domain/usecases/get_doctor_request_appointment.dart';
import 'package:doctor_appointment/domain/usecases/update_appointment.dart';
import 'package:doctor_appointment/presentation/journeys/doctor/doctorHomeScreen/requestAppointment/request_appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestAppointmentList extends StatefulWidget {
  final LoginEntity loginEntity;

  const RequestAppointmentList({Key? key, required this.loginEntity})
      : super(key: key);

  @override
  State<RequestAppointmentList> createState() => _RequestAppointmentListState();
}

class _RequestAppointmentListState extends State<RequestAppointmentList> {
  bool isLoading = true;
  bool isError = false;
  List<AppointmentEntity> appointments = List.empty(growable: true);
  late GetDoctorRequestAppointment getDoctorAppointment;
  late UpdateAppointment updateAppointment;

  @override
  void initState() {
    getDoctorAppointment = getItInstance<GetDoctorRequestAppointment>();
    updateAppointment = getItInstance<UpdateAppointment>();
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
                    'No Appointment Request yet',
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
                        return RequestAppointmentCard(
                          appointmentEntity: appointments[index],
                          accept: () {
                            _updateAppointment(
                                appointments[index].userEmail,
                                appointments[index].docId,
                                1,
                                index,
                                appointments[index].docName,
                                appointments[index].dateTime);
                          },
                          cancel: () {
                            _updateAppointment(
                                appointments[index].userEmail,
                                appointments[index].docId,
                                3,
                                index,
                                appointments[index].docName,
                                appointments[index].dateTime);
                          },
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

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Text(AppString.loading)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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

  void _updateAppointment(String userEmail, String id, int status, int index,
      String doctorName, DateTime timestamp) async {
    showLoaderDialog(context);
    final update = await updateAppointment(AppointmentRequestParam(
        userEmail: userEmail,
        status: status,
        appointmentId: id,
        doctorName: doctorName,
        timestamp: timestamp));
    update.fold((l) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Try again something went wrong"),
        ));
      });
    }, (r) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.pop(context);
        appointments.removeAt(index);
        setState(() {});
      });
    });
  }
}
