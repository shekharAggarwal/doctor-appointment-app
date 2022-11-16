import 'package:community_material_icon/community_material_icon.dart';
import 'package:doctor_appointment/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUserProfile extends StatelessWidget {
  final UserEntity userEntity;

  const AboutUserProfile({Key? key, required this.userEntity})
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
                userEntity.email,
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
          //gender
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 27,
                  width: 27,
                  color: Colors.blue[800],
                  child: const Icon(
                    CommunityMaterialIcons.gender_male_female_variant,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                userEntity.gender,
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
          //bloodGroup
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
                    CommunityMaterialIcons.blood_bag,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                userEntity.bloodGroup,
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
          //DOB
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
                    CommunityMaterialIcons.calendar,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                userEntity.dob,
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
