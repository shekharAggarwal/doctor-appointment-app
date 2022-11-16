import 'package:doctor_appointment/domain/usecases/get_doctor_request_for_admin.dart';
import 'package:doctor_appointment/presentation/journeys/admin/adminDoctorScreen/pendingDoctorView/pending_doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/constants/app_string.dart';
import '../../../../../di/get_it.dart';
import '../../../../../domain/entities/doctor_admin_param.dart';
import '../../../../../domain/entities/doctor_entity.dart';
import '../../../../../domain/entities/no_params.dart';
import '../../../../../domain/usecases/update_doctor_by_admin.dart';

class PendingDoctorView extends StatefulWidget {
  const PendingDoctorView({Key? key}) : super(key: key);

  @override
  _PendingDoctorViewState createState() => _PendingDoctorViewState();
}

class _PendingDoctorViewState extends State<PendingDoctorView> {
  late GetDoctorRequestForAdmin getDoctorRequestForAdmin;
  late UpdateDoctorByAdmin updateDoctorByAdmin;
  bool isLoading = true;
  bool isError = false;
  List<DoctorEntity> doctors = List.empty(growable: true);

  @override
  void initState() {
    getDoctorRequestForAdmin = getItInstance<GetDoctorRequestForAdmin>();
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
                    'No Doctor Request yet',
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
                        return PendingDoctorCard(
                          accept: () {
                            showLoaderDialog(context);
                            _updateDoctor(doctors[index].email, true, index);
                          },
                          reject: () {
                            showLoaderDialog(context);
                            _updateDoctor(doctors[index].email, false, index);
                          },
                          doctorEntity: doctors[index],
                        );
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
    final doctor = await getDoctorRequestForAdmin(NoParams());
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

  void _updateDoctor(String email, bool isApproved, int index) async {
    final isDone = await updateDoctorByAdmin(
        DoctorAdminParam(email: email, isApproved: isApproved));
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
