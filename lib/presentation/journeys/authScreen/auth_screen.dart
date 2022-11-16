import 'package:doctor_appointment/common/constants/app_image.dart';
import 'package:doctor_appointment/common/constants/app_string.dart';
import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:doctor_appointment/presentation/widgets/assets_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AssetsImage(AppImage.imageMedical,
              height: double.maxFinite, width: double.maxFinite),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 80.0, left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.hello,
                      style: GoogleFonts.b612(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      AppString.welcomeMessage,
                      style: GoogleFonts.b612(
                          color: Colors.indigo[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.black26.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: ElevatedButton(
                              child: Text(
                                AppString.signIn,
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () =>
                                  _pushPage(context, RouteList.loginScreen),
                              style: ElevatedButton.styleFrom(
                                elevation: 2,
                                primary: Colors.indigo[800],
                                onPrimary: Colors.indigo[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              padding: const EdgeInsets.only(
                                  top: 16.0,
                                  bottom: 16.0,
                                  left: 16.0,
                                  right: 4.0),
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: ElevatedButton(
                                  child: Text(
                                    AppString.createUserAccount,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () => _pushPage(
                                      context, RouteList.userRegisterScreen),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    primary: Colors.white,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              padding: const EdgeInsets.only(
                                  left: 4.0,
                                  top: 16.0,
                                  bottom: 16.0,
                                  right: 16.0),
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: ElevatedButton(
                                  child: Text(
                                    AppString.createDoctorAccount,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () => _pushPage(
                                      context, RouteList.doctorRegisterScreen),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    primary: Colors.white,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pushPage(BuildContext context, String page) {
    Navigator.of(context).pushNamed(page);
  }
}
