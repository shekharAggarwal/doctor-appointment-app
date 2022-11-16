import 'package:doctor_appointment/presentation/journeys/admin/adminDoctorScreen/acceptedDoctorView/accepted_doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/constants/app_string.dart';
import '../../../../../di/get_it.dart';
import '../../../../../domain/entities/doctor_admin_param.dart';
import '../../../../../domain/entities/doctor_entity.dart';
import '../../../../../domain/entities/no_params.dart';
import '../../../../../domain/usecases/get_doctor_accepted_for_admin.dart';
import '../../../../../domain/usecases/update_doctor_by_admin.dart';

class AcceptedDoctorView extends StatefulWidget {
  const AcceptedDoctorView({Key? key}) : super(key: key);

  @override
  _AcceptedDoctorViewState createState() => _AcceptedDoctorViewState();
}

class _AcceptedDoctorViewState extends State<AcceptedDoctorView> {
  late GetDoctorAcceptedForAdmin getDoctorAcceptedForAdmin;
  late UpdateDoctorByAdmin updateDoctorByAdmin;
  bool isLoading = true;
  bool isError = false;
  List<DoctorEntity> doctors = List.empty(growable: true);

  @override
  void initState() {
    getDoctorAcceptedForAdmin = getItInstance<GetDoctorAcceptedForAdmin>();
    updateDoctorByAdmin = getItInstance<UpdateDoctorByAdmin>();
    getDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : doctors.isEmpty && !isError
              ? Center(
                  child: Text(
                    'No Doctor Accepted yet',
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                )
              : !isError
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return AcceptedDoctorCard(
                            block: () {
                              showLoaderDialog(context);
                              _blockDoctor(doctors[index].email, index);
                            },
                            doctorEntity: doctors[index]);
                      },
                      itemCount: doctors.length)
                  : Center(
                      child: Text(
                        'Error while getting Doctors',
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
    );
  }

  void getDoctors() async {
    final doctor = await getDoctorAcceptedForAdmin(NoParams());
    doctor.fold((l) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
          isError = true;
        });
      });
    }, (r) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        doctors = r;
        setState(() {
          isLoading = false;
          isError = false;
        });
      });
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Text(AppString.loading)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _blockDoctor(String email, int index) async {
    final isDone = await updateDoctorByAdmin(
        DoctorAdminParam(email: email, isApproved: false));
    Navigator.pop(context);
    isDone.fold((l) => false, (r) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          doctors.removeAt(index);
        });
      });
    });
  }
}
