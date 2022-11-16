import 'package:doctor_appointment/domain/entities/prescription_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ViewOldPrescription extends StatefulWidget {
  final PrescriptionEntity prescriptionEntity;

  const ViewOldPrescription({Key? key, required this.prescriptionEntity})
      : super(key: key);

  @override
  _ViewOldPrescriptionState createState() => _ViewOldPrescriptionState();
}

class _ViewOldPrescriptionState extends State<ViewOldPrescription> {
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
          'Old Prescription',
          style: GoogleFonts.lato(
            color: Colors.indigo,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _view(
                  "prescription Id", widget.prescriptionEntity.prescriptionId),
              _view("Email", widget.prescriptionEntity.userEmail),
              _view("doctor Email", widget.prescriptionEntity.docEmail),
              _view(
                  "visit Date",
                  DateFormat('dd-MM-yyyy')
                      .format(widget.prescriptionEntity.visitDate)),
              _view(
                  "Reason For Visit", widget.prescriptionEntity.reasonForVisit),
              _view("Symptoms", widget.prescriptionEntity.symptoms),
              _view("prescription", widget.prescriptionEntity.prescription),
            ],
          ),
        ),
      ),
    );
  }

  Widget _view(String title, String? value) {
    List<String> texts = List.empty(growable: true);
    if (value != null && value.isNotEmpty) texts = value.split(',');
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery
                .of(context)
                .size
                .height,
            minHeight: MediaQuery
                .of(context)
                .size
                .height / 14,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (value != null && value.isNotEmpty)
                  Column(
                    children: texts
                        .map((e) =>
                        Text(
                          e,
                          style: GoogleFonts.lato(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                        .toList(),
                  )
                else
                  Text(
                    "Not Added",
                    style: GoogleFonts.lato(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
