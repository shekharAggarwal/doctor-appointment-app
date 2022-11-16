import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';
import 'package:doctor_appointment/presentation/journeys/doctor/doctorProfile/about_doctor_profile.dart';
import 'package:doctor_appointment/presentation/journeys/doctor/doctorProfile/top_doctor_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorProfile extends StatefulWidget {
  final LoginEntity loginEntity;

  const DoctorProfile({Key? key, required this.loginEntity}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late DoctorEntity doctorEntity;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _getDoctor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : !isError
                ? ListView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      //image, name, logout
                      TopDoctorProfile(name: doctorEntity.name),
                      //about user
                      AboutDoctorProfile(
                        doctorEntity: doctorEntity,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'Error while getting Details',
                      style: GoogleFonts.lato(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
      ),
    );
  }

  void _getDoctor() async {
    if (widget.loginEntity.doctorEntity == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
          isError = true;
        });
      });
    } else {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
          isError = false;
          doctorEntity = widget.loginEntity.doctorEntity!;
        });
      });
    }
  }
}
