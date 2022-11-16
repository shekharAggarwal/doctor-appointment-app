import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:doctor_appointment/domain/entities/prescription_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PrescriptionCard extends StatelessWidget {
  final PrescriptionEntity prescription;

  const PrescriptionCard({Key? key, required this.prescription})
      : super(key: key);

  String _dateFormatter(String _timestamp) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(_timestamp));
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteList.userViewPrescription,
            arguments: prescription);
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 3))
            ],
            borderRadius: BorderRadius.circular(2)),
        margin: const EdgeInsets.only(bottom: 10, right: 20),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              prescription.prescriptionId,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(),
            ),
            Text(
              "Date: " +
                  _dateFormatter(prescription.visitDate.toString()),
              style: GoogleFonts.lato(),
            )
          ],
        ),
      ),
    );
  }
}
