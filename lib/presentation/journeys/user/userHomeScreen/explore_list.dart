import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/usecases/get_doctors_by_type.dart';
import 'package:doctor_appointment/presentation/journeys/user/userHomeScreen/explore_arg.dart';
import 'package:doctor_appointment/presentation/widgets/user_doctor_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreList extends StatefulWidget {
  final ExploreArg exploreArg;

  const ExploreList({Key? key, required this.exploreArg}) : super(key: key);

  @override
  _ExploreListState createState() => _ExploreListState();
}

class _ExploreListState extends State<ExploreList> {
  late GetDoctorsByType getDoctorsByType;
  List<DoctorEntity> docs = List.empty(growable: true);
  bool isError = false;

  @override
  void initState() {
    getDoctorsByType = getItInstance<GetDoctorsByType>();
    _getDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.exploreArg.type + 's',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: docs.isEmpty && !isError
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : !isError
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      return UserDoctorWidget(
                        doc: docs[index],
                        loginEntity: widget.exploreArg.loginEntity,
                      );
                    },
                  )
                : const SizedBox.shrink(),
      ),
    );
  }

  void _getDoctors() async {
    final doctors = await getDoctorsByType(widget.exploreArg.type);
    doctors.fold((l) {
      setState(() {
        isError = true;
      });
    }, (r) {
      setState(() {
        docs = r;
      });
    });
  }
}
