import 'package:doctor_appointment/presentation/widgets/assets_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchErrorWidget extends StatelessWidget {
  const SearchErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Doctor found!',
            style: GoogleFonts.lato(
              color: Colors.blue[800],
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const AssetsImage(
            'assets/error-404.jpg',
            height: 250,
            width: 250,
          ),
        ],
      ),
    );
  }
}
