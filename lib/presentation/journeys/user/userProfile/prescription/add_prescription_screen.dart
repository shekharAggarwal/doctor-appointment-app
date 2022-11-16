import 'package:doctor_appointment/common/constants/app_string.dart';
import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/prescription_param.dart';
import 'package:doctor_appointment/domain/usecases/add_prescription.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddPrescriptionScreen extends StatefulWidget {
  final String email;

  const AddPrescriptionScreen({Key? key, required this.email})
      : super(key: key);

  @override
  _AddPrescriptionScreenState createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _visitDateController = TextEditingController();
  final TextEditingController _reasonForVisitController =
      TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _prescriptionController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode lastNode = FocusNode();

  DateTime selectedDate = DateTime.now();

  late AddPrescription addPrescription;

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1918),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
    ).then(
      (date) {
        setState(
          () {
            selectedDate = date!;
            String formattedDate =
                DateFormat('dd-MM-yyyy').format(selectedDate);
            _visitDateController.text = formattedDate;
          },
        );
      },
    );
  }

  void requestFocus() {
    if (_visitDateController.text.isEmpty) {
      lastNode = f1;
      FocusScope.of(context).requestFocus(f1);
    } else if (_reasonForVisitController.text.isEmpty) {
      lastNode = f2;
      FocusScope.of(context).requestFocus(f2);
    } else if (_symptomsController.text.isEmpty) {
      lastNode = f3;
      FocusScope.of(context).requestFocus(f3);
    } else if (_prescriptionController.text.isEmpty) {
      lastNode = f4;
      FocusScope.of(context).requestFocus(f4);
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

  @override
  void initState() {
    addPrescription = getItInstance<AddPrescription>();
    super.initState();
  }

  @override
  void dispose() {
    _visitDateController.dispose();
    _reasonForVisitController.dispose();
    _symptomsController.dispose();
    _prescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            splashRadius: 20,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.indigo,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Add Prescription',
          style: GoogleFonts.lato(
            color: Colors.indigo,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
              child: _addPrescription(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _addPrescription() {
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
            //visit date
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.topRight,
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
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[350],
                      hintText: 'Date of Visit',
                      hintStyle: GoogleFonts.lato(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    controller: _visitDateController,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please Enter the Date';
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      lastNode.unfocus();
                      requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                    style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0, top: 5.0),
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
              height: 25.0,
            ),
            //reason for visit
            TextFormField(
              focusNode: f2,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.text,
              controller: _reasonForVisitController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.reason,
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
                if (value!.isEmpty) {
                  return AppString.enterReason;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //symptoms
            TextFormField(
              focusNode: f3,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.text,
              controller: _symptomsController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.symptoms,
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
                if (value!.isEmpty) return AppString.enterSymptoms;
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //prescription
            TextFormField(
              focusNode: f4,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.streetAddress,
              controller: _prescriptionController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.prescription,
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
                if (value!.isEmpty) {
                  return AppString.enterPrescription;
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    AppString.addPrescription,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoaderDialog(context);
                      if (await _addPrescriptionFun()) {
                        Navigator.pop(context);
                        final snackBar = SnackBar(
                          content: Row(
                            children: const [
                              Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              Text(AppString.prescriptionAdded),
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
                              Text(AppString.errorPrescriptionAdded),
                            ],
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
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
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _addPrescriptionFun() async {
    final isDone = await addPrescription(PrescriptionParam(
        widget.email,
        null,
        selectedDate,
        _reasonForVisitController.text,
        _symptomsController.text,
        _prescriptionController.text));
    return isDone.fold((l) => false, (r) => true);
  }
}
