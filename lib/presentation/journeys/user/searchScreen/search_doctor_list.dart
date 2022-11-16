import 'package:doctor_appointment/domain/entities/doctor_entity.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';
import 'package:doctor_appointment/presentation/widgets/user_doctor_widget.dart';
import 'package:flutter/material.dart';

class SearchDoctorList extends StatelessWidget {
  final LoginEntity loginEntity;
  final List<DoctorEntity> docs;

  const SearchDoctorList(
      {Key? key, required this.docs, required this.loginEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: docs.length,
        itemBuilder: (context, index) {
          return UserDoctorWidget(
            doc: docs[index],
            loginEntity: loginEntity,
          );
        },
      ),
    );
  }
}
