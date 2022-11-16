import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blockedUserView/blocked_user_view.dart';
import 'userView/user_view.dart';

class AdminUserScreen extends StatelessWidget {
  const AdminUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "User Control",
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
                text: 'User',
              ),
              Tab(
                text: 'Blocked',
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
              child: UserView(),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10, top: 10),
              child: BlockedUserView(),
            ),
          ],
        ),
      ),
    );
  }
}
