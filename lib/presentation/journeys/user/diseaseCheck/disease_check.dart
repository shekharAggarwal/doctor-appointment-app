import 'package:community_material_icon/community_material_icon.dart';
import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseaseCheck extends StatelessWidget {
  const DiseaseCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Disease',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_sharp,
            color: Colors.indigo,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteList.userHeartDisease);
              },
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CommunityMaterialIcons.heart,
                        color: Colors.red,
                        size: 50,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Check Heart",
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteList.userLungDisease);
              },
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CommunityMaterialIcons.lungs,
                        color: Colors.redAccent,
                        size: 50,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Check Lungs",
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
