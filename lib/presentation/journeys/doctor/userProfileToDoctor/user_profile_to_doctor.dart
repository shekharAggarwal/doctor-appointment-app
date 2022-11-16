import 'package:doctor_appointment/common/constants/app_string.dart';
import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/doctor_prescription_param.dart';
import 'package:doctor_appointment/domain/entities/user_doctor_param.dart';
import 'package:doctor_appointment/domain/entities/user_for_doctor_entity.dart';
import 'package:doctor_appointment/domain/usecases/add_prescription_by_doctor.dart';
import 'package:doctor_appointment/domain/usecases/get_user_for_doctor.dart';
import 'package:doctor_appointment/presentation/journeys/doctor/userProfileToDoctor/about_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'user_prescription.dart';
import 'user_profile_arguments.dart';

class UserProfileToDoctor extends StatefulWidget {
  final UserProfileArguments profileArguments;

  const UserProfileToDoctor({Key? key, required this.profileArguments})
      : super(key: key);

  @override
  _UserProfileToDoctorState createState() => _UserProfileToDoctorState();
}

class _UserProfileToDoctorState extends State<UserProfileToDoctor> {
  late GetUserForDoctor getUserForDoctor;
  late UserForDoctorEntity userForDoctorEntity;
  late AddPrescriptionByDoctor addPrescriptionByDoctor;
  bool isLoading = true;
  bool isError = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _reasonForVisitController =
      TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _prescriptionController = TextEditingController();

  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode lastNode = FocusNode();

  @override
  void initState() {
    super.initState();
    addPrescriptionByDoctor = getItInstance<AddPrescriptionByDoctor>();
    getUserForDoctor = getItInstance<GetUserForDoctor>();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            splashRadius: 20,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.indigo,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'User Info',
          style: GoogleFonts.lato(
            color: Colors.indigo,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : !isError
                ? ListView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      AboutUser(userEntity: userForDoctorEntity.user),
                      UserPrescription(
                        prescriptions: userForDoctorEntity.prescriptions,
                      ),
                      _addPrescription(),
                      const SizedBox(
                        height: 20,
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

  Widget _addPrescription() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            //reason for visit
            TextFormField(
              focusNode: f2,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.text,
              controller: _reasonForVisitController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.reason,
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                lastNode.unfocus();
                requestFocus();
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppString.enterReason;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //symptoms
            TextFormField(
              focusNode: f3,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.text,
              controller: _symptomsController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.symptoms,
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                lastNode.unfocus();
                requestFocus();
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return AppString.enterSymptoms;
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //prescription
            TextFormField(
              focusNode: f4,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.streetAddress,
              controller: _prescriptionController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.prescription,
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                lastNode.unfocus();
                requestFocus();
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppString.enterPrescription;
                }
                return null;
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: MediaQuery.of(context).size.height / 14,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey[50],
              ),
              child: TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    showLoaderDialog(context);
                    if (await _addPrescriptionFun()) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteList.doctorHomeScreen, (_) => false,
                          arguments: widget.profileArguments.loginEntity);
                    } else {
                      Navigator.pop(context);
                      final snackBar = SnackBar(
                        content: Row(
                          children: const [
                            Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                            Text(AppString.errorPrescriptionAdded),
                          ],
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
                style: TextButton.styleFrom(primary: Colors.grey),
                child: Text(
                  AppString.addPrescription,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void requestFocus() {
    if (_reasonForVisitController.text.isEmpty) {
      lastNode = f2;
      FocusScope.of(context).requestFocus(f2);
    } else if (_symptomsController.text.isEmpty) {
      lastNode = f3;
      FocusScope.of(context).requestFocus(f3);
    } else if (_prescriptionController.text.isEmpty) {
      lastNode = f4;
      FocusScope.of(context).requestFocus(f4);
    }
  }

  void _getUser() async {
    final user = await getUserForDoctor(UserDoctorParam(
        userEmail: widget.profileArguments.appointmentEntity.userEmail,
        uid: widget.profileArguments.appointmentEntity.userId));
    user.fold((l) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
          isError = true;
        });
      });
    }, (r) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        userForDoctorEntity = r;
        setState(() {
          isLoading = false;
          isError = false;
        });
      });
    });
  }

  Future<bool> _addPrescriptionFun() async {
    final prescription = await addPrescriptionByDoctor(DoctorPrescriptionParam(
        userForDoctorEntity.user.email,
        widget.profileArguments.loginEntity.doctorEntity!.email,
        DateTime.now(),
        _reasonForVisitController.text,
        _symptomsController.text,
        _prescriptionController.text,
        widget.profileArguments.appointmentEntity.docId));
    return prescription.fold((l) => false, (r) => true);
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
}
