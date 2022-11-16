import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckDiseaseBanner extends StatelessWidget {
  const CheckDiseaseBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.maxFinite,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          stops: [0.3, 0.7],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xffa1d4ed),
            Color(0xffc0eaff),
          ],
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteList.userCheckDisease);
        },
        child: Stack(
          children: [
            Image.asset(
              "assets/414-bg.png",
              fit: BoxFit.fitHeight,
            ),
            Container(
              padding: const EdgeInsets.only(top: 7, right: 5),
              alignment: Alignment.topRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Check Disease",
                    //'Check Disease',
                    style: GoogleFonts.lato(
                      color: Colors.lightBlue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.lightBlue[900],
                    size: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
