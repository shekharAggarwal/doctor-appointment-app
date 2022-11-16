import 'package:doctor_appointment/domain/entities/prescription_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UserPrescription extends StatelessWidget {
  final List<PrescriptionEntity> prescriptions;

  const UserPrescription({Key? key, required this.prescriptions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return prescriptions.isNotEmpty
        ? Column(
            children: prescriptions
                .map((e) => Card(
                      child: ExpansionTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            e.prescriptionId,
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            DateFormat('dd/MM/yyyy')
                                    .format(e.visitDate) +
                                " " +
                                DateFormat.jm().format(e.visitDate),
                            style: GoogleFonts.lato(),
                          ),
                        ),
                        children: [
                          _view(context, "prescription Id", e.prescriptionId),
                          _view(context, "Email", e.userEmail),
                          _view(context, "doctor Email", e.docEmail),
                          _view(
                              context,
                              "visit Date",
                              DateFormat('dd-MM-yyyy')
                                  .format(e.visitDate)),
                          _view(context, "Reason For Visit", e.reasonForVisit),
                          _view(context, "Symptoms", e.symptoms),
                          _view(context, "prescription", e.prescription),
                        ],
                      ),
                    ))
                .toList(),
          )
        : const SizedBox.shrink();
  }

  Widget _view(BuildContext context, String title, String? value) {
    List<String> texts = List.empty(growable: true);
    if (value != null && value.isNotEmpty) texts = value.split(',');
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.height,
            minHeight: MediaQuery.of(context).size.height / 14,
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
                        .map((e) => Text(
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
