import 'package:doctor_appointment/domain/entities/prescription_entity.dart';
import 'package:flutter/material.dart';

import 'prescription_card.dart';

class PrescriptionListView extends StatelessWidget {
  final List<PrescriptionEntity> prescriptions;

  const PrescriptionListView({Key? key, required this.prescriptions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: prescriptions
          .map((e) => PrescriptionCard(
                prescription: e,
              ))
          .toList(),
    );
  }
}
