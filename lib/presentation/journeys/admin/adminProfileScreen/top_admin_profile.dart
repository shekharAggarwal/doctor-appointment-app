import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/no_params.dart';
import 'package:doctor_appointment/domain/usecases/remove_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopAdminProfile extends StatefulWidget {
  final String name;

  const TopAdminProfile({Key? key, required this.name}) : super(key: key);

  @override
  State<TopAdminProfile> createState() => _TopDoctorProfileState();
}

class _TopDoctorProfileState extends State<TopAdminProfile> {
  late final RemoveLogin _removeLogin;

  Future _signOut() async {
    await _removeLogin(NoParams());
  }

  @override
  void initState() {
    _removeLogin = getItInstance<RemoveLogin>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: [
            //logout
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.5],
                  colors: [
                    Colors.indigo,
                    Colors.indigoAccent,
                  ],
                ),
              ),
              height: MediaQuery.of(context).size.height / 5,
              child: Container(
                padding: const EdgeInsets.only(top: 10, right: 7),
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteList.authScreen, (Route<dynamic> route) => false);
                    _signOut();
                  },
                ),
              ),
            ),
            //name
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 5,
              padding: const EdgeInsets.only(top: 75),
              child: Text(
                widget.name,
                style: GoogleFonts.lato(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        //image
        Container(
          child: const CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/person.jpg'),
          ),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal.shade50,
                width: 5,
              ),
              shape: BoxShape.circle),
        ),
      ],
    );
  }
}