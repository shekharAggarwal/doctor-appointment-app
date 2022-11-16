import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../../../common/constants/app_string.dart';

class HeartCheck extends StatefulWidget {
  const HeartCheck({Key? key}) : super(key: key);

  @override
  _HeartCheckState createState() => _HeartCheckState();
}

class _HeartCheckState extends State<HeartCheck> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _age = TextEditingController();
  final TextEditingController _rbp = TextEditingController();
  final TextEditingController _cholesterol = TextEditingController();
  final TextEditingController _ecg = TextEditingController();
  final TextEditingController _heartRate = TextEditingController();
  final TextEditingController _oldPeak = TextEditingController();
  final TextEditingController _slope = TextEditingController();
  final TextEditingController _ca = TextEditingController();
  final TextEditingController _thal = TextEditingController();

  final genders = ['Male', 'Female'];
  final cpLevel = ['0', '1', '2', '3'];
  final yes_no = ['No', 'Yes'];
  double gender = 0.0;
  double cp = 0.0;
  double fbs = 0.0;
  double exang = 0.0;

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();
  FocusNode f7 = FocusNode();
  FocusNode f8 = FocusNode();
  FocusNode f9 = FocusNode();
  FocusNode lastNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      ),
      body: SingleChildScrollView(
        child: _heartCheck(),
      ),
    );
  }

  Widget _heartCheck() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            //Heart Check TEXT
            Container(
              padding: const EdgeInsets.only(bottom: 50),
              child: Text(
                AppString.heartCheck,
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //AGE
            TextFormField(
              focusNode: f1,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: const TextInputType.numberWithOptions(),
              controller: _age,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.age,
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                lastNode.unfocus();
                requestFocus();
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return AppString.ageError;
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //GENDER
            DropdownButtonFormField(
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              hint: Text(
                "Male",
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintStyle: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              items: genders
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (gen) {
                gender = gen == "Male" ? 0.0 : 1.0;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //Chest Pain
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Chest Pain Level(0 to 3)",
                  style: GoogleFonts.lato(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            DropdownButtonFormField(
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              hint: Text(
                "0",
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintStyle: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              items: cpLevel
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (gen) {
                switch (gen) {
                  case "0":
                    cp = 0.0;
                    break;
                  case "1":
                    cp = 1.0;
                    break;
                  case "2":
                    cp = 2.0;
                    break;
                  case "3":
                    cp = 3.0;
                    break;
                  default:
                    cp = 0.0;
                }
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //RESTING BLOOD PRESSURE
            TextFormField(
              focusNode: f2,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: const TextInputType.numberWithOptions(),
              controller: _rbp,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.rbp,
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                lastNode.unfocus();
                requestFocus();
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return AppString.rbpError;
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //CHOLESTEROL
            TextFormField(
              focusNode: f3,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: const TextInputType.numberWithOptions(),
              controller: _cholesterol,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.cholesterol,
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                lastNode.unfocus();
                requestFocus();
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return AppString.cholesterolError;
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),

            //Fasting Blood Sugar
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Fasting Blood Sugar>120 mg/dl (Yes/No)",
                  style: GoogleFonts.lato(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            DropdownButtonFormField(
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              hint: Text(
                "No",
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintStyle: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              items: yes_no
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (gen) {
                switch (gen) {
                  case "No":
                    fbs = 0.0;
                    break;
                  case "Yes":
                    fbs = 1.0;
                    break;
                  default:
                    fbs = 0.0;
                }
              },
            ),
            const SizedBox(
              height: 25.0,
            ),

            //Resting Electrocardiography Result
            TextFormField(
              focusNode: f4,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: const TextInputType.numberWithOptions(),
              controller: _ecg,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.ecg,
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                lastNode.unfocus();
                requestFocus();
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return AppString.ecgError;
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),

            //Maximum Heart Rate Achieved
            TextFormField(
              focusNode: f5,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: const TextInputType.numberWithOptions(),
              controller: _heartRate,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.heartRate,
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                lastNode.unfocus();
                requestFocus();
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return AppString.heartRateError;
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),

            //Exercise Induced Angina
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Exercise Induced Angina(Yes/No)",
                  style: GoogleFonts.lato(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            DropdownButtonFormField(
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              hint: Text(
                "No",
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintStyle: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              items: yes_no
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (gen) {
                switch (gen) {
                  case "No":
                    exang = 0.0;
                    break;
                  case "Yes":
                    exang = 1.0;
                    break;
                  default:
                    exang = 0.0;
                }
              },
            ),
            const SizedBox(
              height: 25.0,
            ),

            //ST Depression Induced By Exercise Relative To Rest
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  AppString.oldPeak,
                  style: GoogleFonts.lato(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextFormField(
              focusNode: f6,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: const TextInputType.numberWithOptions(),
              controller: _oldPeak,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.oldPeak,
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                lastNode.unfocus();
                requestFocus();
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return AppString.oldPeakError;
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),

            //The Slope of the peak exercise ST Segment
            TextFormField(
              focusNode: f7,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: const TextInputType.numberWithOptions(),
              controller: _slope,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.slope,
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                lastNode.unfocus();
                requestFocus();
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return AppString.slopeError;
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),

            //Number of Major Vessels Colored By Fluoroscopy
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  AppString.ca,
                  style: GoogleFonts.lato(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextFormField(
              focusNode: f8,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: const TextInputType.numberWithOptions(),
              controller: _ca,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.ca,
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                lastNode.unfocus();
                requestFocus();
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return AppString.caError;
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),

            //A blood disorder called thalassemia
            TextFormField(
              focusNode: f9,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: const TextInputType.numberWithOptions(),
              controller: _thal,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.thal,
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                lastNode.unfocus();
                requestFocus();
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return AppString.thalError;
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    AppString.checkHeart,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoaderDialog(context);
                      _checkHeartDisease();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    primary: Colors.indigo[900],
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void requestFocus() {
    if (_age.text.isEmpty) {
      lastNode = f1;
      FocusScope.of(context).requestFocus(f1);
    } else if (_rbp.text.isEmpty) {
      lastNode = f2;
      FocusScope.of(context).requestFocus(f2);
    } else if (_cholesterol.text.isEmpty) {
      lastNode = f3;
      FocusScope.of(context).requestFocus(f3);
    } else if (_ecg.text.isEmpty) {
      lastNode = f4;
      FocusScope.of(context).requestFocus(f4);
    } else if (_heartRate.text.isEmpty) {
      lastNode = f5;
      FocusScope.of(context).requestFocus(f5);
    } else if (_oldPeak.text.isEmpty) {
      lastNode = f6;
      FocusScope.of(context).requestFocus(f6);
    } else if (_slope.text.isEmpty) {
      lastNode = f7;
      FocusScope.of(context).requestFocus(f7);
    } else if (_ca.text.isEmpty) {
      lastNode = f8;
      FocusScope.of(context).requestFocus(f8);
    } else if (_thal.text.isEmpty) {
      lastNode = f9;
      FocusScope.of(context).requestFocus(f9);
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Text(AppString.loading)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _checkHeartDisease() async {
    try {
      final interpreter = await Interpreter.fromAsset("ml_model/heart.tflite");
      var input = [
        [
          double.parse(_age.text),
          gender,
          cp,
          double.parse(_rbp.text),
          double.parse(_cholesterol.text),
          fbs,
          double.parse(_ecg.text),
          double.parse(_heartRate.text),
          exang,
          double.parse(_oldPeak.text),
          double.parse(_slope.text),
          double.parse(_ca.text),
          double.parse(_thal.text)
        ]
      ];
      var output = List.filled(2, 0).reshape([1, 2]);
      interpreter.run(input, output);
      Navigator.pop(context);
      showAlertDialog(
          context,
          double.parse((output[0][0]).toStringAsFixed(3)) <
              double.parse((output[0][1]).toStringAsFixed(3)));
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            Text(
              e.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ));
    }
  }

  showAlertDialog(BuildContext context, bool isTrue) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("close"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Result"),
      content: Text(
        isTrue ? "You have heart disease" : "You don't have heart disease",
        style: GoogleFonts.lato(
          color: isTrue ? Colors.red : Colors.green,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
