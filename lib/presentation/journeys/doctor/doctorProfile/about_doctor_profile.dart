import 'package:community_material_icon/community_material_icon.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutDoctorProfile extends StatelessWidget {
  final DoctorEntity doctorEntity;

  const AboutDoctorProfile({Key? key, required this.doctorEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey[50],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //mail
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 27,
                  width: 27,
                  color: Colors.red[900],
                  child: const Icon(
                    Icons.mail_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                doctorEntity.email,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          //specialization
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 27,
                  width: 27,
                  color: Colors.red[800],
                  child: const Icon(
                    CommunityMaterialIcons.stethoscope,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                doctorEntity.specialization,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          //address
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 27,
                  width: 27,
                  color: Colors.pink[800],
                  child: const Icon(
                    Icons.place_sharp,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                doctorEntity.address,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
