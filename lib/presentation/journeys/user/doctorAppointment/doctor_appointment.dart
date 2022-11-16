import 'package:doctor_appointment/common/constants/app_string.dart';
import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/appointment_param.dart';
import 'package:doctor_appointment/domain/usecases/add_appointment.dart';
import 'package:doctor_appointment/presentation/journeys/user/doctorAppointment/doctor_arguments.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorAppointment extends StatefulWidget {
  final DoctorArguments doctorArguments;

  const DoctorAppointment({Key? key, required this.doctorArguments})
      : super(key: key);

  @override
  _DoctorAppointmentState createState() => _DoctorAppointmentState();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();

  DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  TimeOfDay? selectedTime;

  late String dateUTC;
  late String dateTime;
  String timeText = 'Select Time';

  late AddAppointment addAppointment;

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
      lastDate: DateTime(
          DateTime.now().year + 2, DateTime.now().month, DateTime.now().day),
    ).then(
      (date) {
        if (date != null) {
          setState(
            () {
              selectedDate = date;
              String formattedDate =
                  DateFormat('dd-MM-yyyy').format(selectedDate);
              _dateController.text = formattedDate;
              dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
            },
          );
        }
      },
    );
  }

  Future<void> selectTime(BuildContext context) async {
    selectedTime = (await showTimePicker(
      context: context,
      initialTime: currentTime,
    ))!;

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(selectedTime!,
        alwaysUse24HourFormat: false);

    setState(() {
      timeText = formattedTime;
      _timeController.text = timeText;
    });
    dateTime = selectedTime.toString().substring(10, 15);
  }

  _launchEmail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    addAppointment = getItInstance<AddAppointment>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.only(top: 5),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 5),
                  child: IconButton(
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
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.doctorArguments.doctor.image),
                  //backgroundColor: Colors.lightBlue[100],
                  radius: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.doctorArguments.doctor.name,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.doctorArguments.doctor.specialization,
                  style: GoogleFonts.lato(
                      //fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(Icons.place_outlined),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Text(
                          widget.doctorArguments.doctor.address,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 12,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(Icons.mail_rounded),
                      const SizedBox(
                        width: 11,
                      ),
                      TextButton(
                        onPressed: () => _launchEmail(
                            "mailto:" + widget.doctorArguments.doctor.email),
                        child: Text(
                          widget.doctorArguments.doctor.email,
                          style: GoogleFonts.lato(
                              fontSize: 16, color: Colors.blue),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                        focusNode: f1,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            left: 20,
                            top: 10,
                            bottom: 10,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Select Date*',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        controller: _dateController,
                        validator: (value) {
                          if (value!.isEmpty) return 'Please Enter the Date';
                          return null;
                        },
                        onFieldSubmitted: (String value) {
                          f1.unfocus();
                          FocusScope.of(context).requestFocus(f2);
                        },
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.lato(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: ClipOval(
                          child: Material(
                            color: Colors.indigo, // button color
                            child: InkWell(
                              // inkwell color
                              child: const SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                selectDate(context);
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                        focusNode: f2,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            left: 20,
                            top: 10,
                            bottom: 10,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Select Time*',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        controller: _timeController,
                        validator: (value) {
                          if (value!.isEmpty) return 'Please Enter the Time';
                          return null;
                        },
                        onFieldSubmitted: (String value) {
                          f2.unfocus();
                        },
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.lato(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: ClipOval(
                          child: Material(
                            color: Colors.indigo, // button color
                            child: InkWell(
                              // inkwell color
                              child: const SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.timer_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                selectTime(context);
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      primary: Colors.indigo.withOpacity(0.9),
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    onPressed: () async {
                      if (validateDateTime()) {
                        showLoaderDialog(context);
                        if (await bookAppointment()) {
                          Navigator.pop(context);
                          final snackBar = SnackBar(
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                ),
                                Text("Appointment Booked!"),
                              ],
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.pop(context);
                          final snackBar = SnackBar(
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                ),
                                Text(
                                    "Error while booking Appointment. Try again!"),
                              ],
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        final snackBar = SnackBar(
                          content: Row(
                            children: const [
                              Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              Text("Select Correct Time!"),
                            ],
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text(
                      'Book an Appointment',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  bool validateDateTime() {
    if (_dateController.text.isEmpty ||
        _timeController.text.isEmpty ||
        selectedTime == null) return false;
    DateTime dateTime = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedTime!.hour, selectedTime!.minute);

    return DateTime.now().isBefore(dateTime);
  }

  Future<bool> bookAppointment() async {
    final isDone = await addAppointment(AppointmentParam(
      docEmail: widget.doctorArguments.doctor.email,
      timeOfDay: dateTime,
      dateTime: dateUTC,
      docName: widget.doctorArguments.doctor.name,
      userId: widget.doctorArguments.loginEntity.userEntity!.uid,
      time: _timeController.text,
      name: widget.doctorArguments.loginEntity.userEntity!.name,
      date: _dateController.text,
      userEmail: widget.doctorArguments.loginEntity.userEntity!.email,
    ));
    return isDone.fold((l) => false, (r) => r);
  }
}
