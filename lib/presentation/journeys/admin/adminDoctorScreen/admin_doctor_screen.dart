import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'acceptedDoctorView/accepted_doctor_view.dart';
import 'pendingDoctorView/pending_doctor_view.dart';
import 'rejectedDoctorView/rejected_doctor_view.dart';

class AdminDoctorScreen extends StatelessWidget {
  const AdminDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Doctor Control",
            style: GoogleFonts.lato(
              color: Colors.black54,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Accepted',
              ),
              Tab(
                text: 'Rejected',
              ),
            ],
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: const TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10, top: 10),
              child: PendingDoctorView(),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10, top: 10),
              child: AcceptedDoctorView(),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10, top: 10),
              child: RejectedDoctorView(),
            ),
          ],
        ),
      ),
    );
  }
}
