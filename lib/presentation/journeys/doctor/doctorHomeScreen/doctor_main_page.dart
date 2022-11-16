import 'package:doctor_appointment/domain/entities/login_entity.dart';
import 'package:doctor_appointment/presentation/journeys/doctor/completedAppointment/completed_appointment.dart';
import 'package:doctor_appointment/presentation/journeys/doctor/doctorProfile/doctor_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'doctor_home_screen.dart';

class DoctorMainPage extends StatefulWidget {
  final LoginEntity loginEntity;

  const DoctorMainPage({Key? key, required this.loginEntity}) : super(key: key);

  @override
  _DoctorMainPageState createState() => _DoctorMainPageState();
}

class _DoctorMainPageState extends State<DoctorMainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    _pages = [
      DoctorHomeScreen(
        loginEntity: widget.loginEntity,
      ),
      CompletedAppointment(
        loginEntity: widget.loginEntity,
      ),
      DoctorProfile(
        loginEntity: widget.loginEntity,
      ),
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: GNav(
                curve: Curves.easeOutExpo,
                rippleColor: Colors.grey.shade300,
                hoverColor: Colors.grey.shade100,
                haptic: true,
                tabBorderRadius: 20,
                gap: 5,
                activeColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.blue.withOpacity(0.7),
                textStyle: GoogleFonts.lato(
                  color: Colors.white,
                ),
                tabs: [
                  GButton(
                    iconSize: _selectedIndex != 0 ? 28 : 25,
                    icon:
                        _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                    text: 'Home',
                  ),
                  GButton(
                    iconSize: 28,
                    icon: _selectedIndex == 1
                        ? Icons.description
                        : Icons.description_outlined,
                    text: 'Completed',
                  ),
                  GButton(
                    iconSize: 29,
                    icon: _selectedIndex == 2
                        ? Icons.person
                        : Icons.person_outline,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
