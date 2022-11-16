import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/prescription_entity.dart';
import 'package:doctor_appointment/domain/usecases/get_user_prescription.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presription_listview.dart';

class PrescriptionView extends StatefulWidget {
  const PrescriptionView({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<PrescriptionView> createState() => _PrescriptionViewState();
}

class _PrescriptionViewState extends State<PrescriptionView> {
  bool isLoading = true;
  bool isError = false;
  late List<PrescriptionEntity> prescriptions;
  late GetUserPrescription getUserPrescription;

  @override
  void initState() {
    getUserPrescription = getItInstance<GetUserPrescription>();
    _getPrescription();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
      ),
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey[50],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 27,
                      width: 27,
                      color: Colors.indigo[600],
                      child: const Icon(
                        Icons.description_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Prescriptions',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteList.userAddPrescription,
                        arguments: widget.email);
                  },
                  icon: const Icon(Icons.add)),
            ],
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (isError)
            Center(
              child: Text(
                'Error while getting Details',
                style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            )
          else if (prescriptions.isEmpty)
            Center(
              child: Text(
                'No prescription add yet',
                style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            )
          else
            PrescriptionListView(
              prescriptions: prescriptions,
            )
        ],
      ),
    );
  }

  void _getPrescription() async {
    final prescription = await getUserPrescription(widget.email);
    prescription.fold((l) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
          isError = true;
        });
      });
    }, (r) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        prescriptions = r;
        setState(() {
          isLoading = false;
          isError = false;
        });
      });
    });
  }
}
