import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';
import 'package:doctor_appointment/domain/entities/no_params.dart';
import 'package:doctor_appointment/domain/usecases/get_doctors.dart';
import 'package:doctor_appointment/presentation/widgets/user_doctor_widget.dart';
import 'package:flutter/material.dart';

class TopRatedList extends StatefulWidget {
  final LoginEntity loginEntity;

  const TopRatedList({Key? key, required this.loginEntity}) : super(key: key);

  @override
  _TopRatedListState createState() => _TopRatedListState();
}

class _TopRatedListState extends State<TopRatedList> {
  late GetDoctors getDoctors;
  List<DoctorEntity> docs = List.empty(growable: true);
  bool isError = false;

  @override
  void initState() {
    getDoctors = getItInstance<GetDoctors>();
    _getDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: docs.isEmpty && !isError
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : !isError
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: docs.length > 5 ? 5 : docs.length,
                  itemBuilder: (context, index) {
                    return UserDoctorWidget(
                      doc: docs[index],
                      loginEntity: widget.loginEntity,
                    );
                  },
                )
              : const SizedBox.shrink(),
    );
  }

  void _getDoctors() async {
    final doctors = await getDoctors(NoParams());
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
