import 'package:doctor_appointment/common/constants/app_image.dart';
import 'package:doctor_appointment/common/constants/app_string.dart';
import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SkipScreen extends StatefulWidget {
  const SkipScreen({Key? key}) : super(key: key);

  @override
  _SkipScreenState createState() => _SkipScreenState();
}

class _SkipScreenState extends State<SkipScreen> {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        title: '',
        image: Image.asset(
          AppImage.doc,
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppString.searchDoc,
              style:
                  GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            Text(
              AppString.docDesc,
              style: GoogleFonts.lato(
                  fontSize: 15,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
      PageViewModel(
        title: '',
        image: Image.asset(
          AppImage.disease,
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppString.searchDisease,
              style:
                  GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            Text(
              AppString.diseaseDesc,
              style: GoogleFonts.lato(
                  fontSize: 15,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: SafeArea(
        child: IntroductionScreen(
          globalBackgroundColor: Colors.lightBlue[100],
          pages: getPages(),
          showNextButton: false,
          showSkipButton: true,
          skip: SizedBox(
            width: 80,
            height: 48,
            child: Card(
              child: Center(
                child: Text(
                  AppString.skip,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontSize: 25, fontWeight: FontWeight.w900),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.blue[300],
              shadowColor: Colors.blueGrey[100],
              elevation: 5,
            ),
          ),
          done: SizedBox(
            height: 48,
            child: Card(
              child: Center(
                child: Text(
                  AppString.continueString,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontSize: 15, fontWeight: FontWeight.w900),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.blue[300],
              shadowColor: Colors.blueGrey[200],
              elevation: 5,
            ),
          ),
          onDone: () => _pushPage(context, RouteList.authScreen),
        ),
      ),
    );
  }

  void _pushPage(BuildContext context, String page) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(page, (Route<dynamic> route) => false);
  }
}
