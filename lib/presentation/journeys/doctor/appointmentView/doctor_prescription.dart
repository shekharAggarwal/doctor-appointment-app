import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/prescription_entity.dart';
import 'package:doctor_appointment/domain/usecases/get_prescription.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DoctorPrescription extends StatefulWidget {
  final String pId;

  const DoctorPrescription({Key? key, required this.pId}) : super(key: key);

  @override
  State<DoctorPrescription> createState() => _DoctorPrescriptionState();
}

class _DoctorPrescriptionState extends State<DoctorPrescription> {
  late PrescriptionEntity prescriptionEntity;
  late GetPrescription getPrescription;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    getPrescription = getItInstance<GetPrescription>();
    _getPrescription();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: isLoading
          ? const SizedBox(
              height: 150,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : !isError
              ? ExpansionTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      prescriptionEntity.prescriptionId,
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
                              .format(prescriptionEntity.visitDate) +
                          " " +
                          DateFormat.jm().format(prescriptionEntity.visitDate),
                      style: GoogleFonts.lato(),
                    ),
                  ),
                  children: [
                    _view(context, "prescription Id",
                        prescriptionEntity.prescriptionId),
                    _view(context, "Email", prescriptionEntity.userEmail),
                    _view(context, "doctor Email", prescriptionEntity.docEmail),
                    _view(
                        context,
                        "visit Date",
                        DateFormat('dd-MM-yyyy')
                            .format(prescriptionEntity.visitDate)),
                    _view(context, "Reason For Visit",
                        prescriptionEntity.reasonForVisit),
                    _view(context, "Symptoms", prescriptionEntity.symptoms),
                    _view(context, "prescription",
                        prescriptionEntity.prescription),
                  ],
                )
              : SizedBox(
                  height: 150,
                  child: Center(
                    child: Text(
                      'Error while getting Prescription',
                      style: GoogleFonts.lato(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
    );
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

  void _getPrescription() async {
    final prescription = await getPrescription(widget.pId);
    prescription.fold((l) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
          isError = true;
        });
      });
    }, (r) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        prescriptionEntity = r;
        setState(() {
          isLoading = false;
          isError = false;
        });
      });
    });
  }
}
