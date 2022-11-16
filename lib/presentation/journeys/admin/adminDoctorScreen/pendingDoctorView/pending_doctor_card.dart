import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../domain/entities/doctor_entity.dart';

class PendingDoctorCard extends StatelessWidget {
  final VoidCallback reject;
  final VoidCallback accept;
  final DoctorEntity doctorEntity;

  const PendingDoctorCard(
      {Key? key,
      required this.reject,
      required this.accept,
      required this.doctorEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        doctorEntity.name,
                        style: GoogleFonts.lato(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        doctorEntity.specialization,
                        style: GoogleFonts.lato(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        doctorEntity.address,
                        style: GoogleFonts.lato(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        doctorEntity.email,
                        style: GoogleFonts.lato(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        doctorEntity.uid,
                        style: GoogleFonts.lato(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        reject();
                      },
                      child: const Center(
                        child: Icon(
                          Icons.clear_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        accept();
                      },
                      child: const Center(
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
