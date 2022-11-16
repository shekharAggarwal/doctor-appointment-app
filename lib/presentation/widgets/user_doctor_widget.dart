import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';
import 'package:doctor_appointment/presentation/journeys/user/doctorAppointment/doctor_arguments.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDoctorWidget extends StatelessWidget {
  final DoctorEntity doc;
  final LoginEntity loginEntity;

  const UserDoctorWidget(
      {Key? key, required this.doc, required this.loginEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Card(
        color: Colors.blue[50],
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 9,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, RouteList.userDoctorAppointmentScreen,
                  arguments: DoctorArguments(doc,loginEntity));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(doc.image),
                  radius: 25,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      doc.name,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      doc.specialization,
                      style:
                          GoogleFonts.lato(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
