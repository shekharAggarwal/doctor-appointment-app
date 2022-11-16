import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/appointment_entity.dart';
import 'package:doctor_appointment/domain/usecases/cancel_appointment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PendingCard extends StatefulWidget {
  final VoidCallback cancelled;
  final AppointmentEntity appointment;

  const PendingCard(
      {Key? key, required this.cancelled, required this.appointment})
      : super(key: key);

  @override
  State<PendingCard> createState() => _PendingCardState();
}

class _PendingCardState extends State<PendingCard> {
  late String _documentID;
  late CancelAppointment cancelAppointment;

  @override
  void initState() {
    cancelAppointment = getItInstance<CancelAppointment>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                widget.appointment.docName,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              _compareDate(widget.appointment.dateTime.toString())
                  ? "TODAY"
                  : "",
              style: GoogleFonts.lato(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            _dateFormatter(widget.appointment.dateTime.toString()),
            style: GoogleFonts.lato(),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 10, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Patient name: " + widget.appointment.name,
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
                            widget.appointment.dateTime.toString(),
                          ),
                      style: GoogleFonts.lato(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.appointment.isAccepted == 1)
                      Text(
                        "Accepted",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
                if (widget.appointment.isAccepted == 0)
                  IconButton(
                    tooltip: 'Delete Appointment',
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      _documentID = widget.appointment.docId;
                      showAlertDialog(context);
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _compareDate(String _date) {
    if (_dateFormatter(DateTime.now().toString())
            .compareTo(_dateFormatter(_date)) ==
        0) {
      return true;
    } else {
      return false;
    }
  }

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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () async {
        if (await cancelAppointmentFun(_documentID)) {
          widget.cancelled();
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Error while cancelling appointment. Try Again!")));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm Cancel"),
      content: const Text("Are you sure you want to cancel this Appointment?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> cancelAppointmentFun(String docID) async {
    final cancel = await cancelAppointment(docID);
    return cancel.fold((l) => false, (r) => true);
  }
}
