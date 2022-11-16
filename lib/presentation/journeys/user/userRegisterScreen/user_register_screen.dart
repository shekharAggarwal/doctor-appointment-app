import 'package:doctor_appointment/common/constants/app_string.dart';
import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/app_error.dart';
import 'package:doctor_appointment/domain/entities/user_register_param.dart';
import 'package:doctor_appointment/domain/usecases/register_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);

  @override
  _UserRegisterScreenState createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _insuranceNumberController =
      TextEditingController();
  final TextEditingController _heartController = TextEditingController();
  final TextEditingController _allergyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();
  FocusNode f7 = FocusNode();
  FocusNode f8 = FocusNode();
  FocusNode f9 = FocusNode();
  FocusNode f10 = FocusNode();
  FocusNode f11 = FocusNode();
  FocusNode f12 = FocusNode();
  FocusNode f13 = FocusNode();
  FocusNode f14 = FocusNode();
  FocusNode lastNode = FocusNode();
  var genders = ['Male', 'Female', 'Other'];
  var bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String bloodGroup = 'A+';
  String gender = 'Male';
  DateTime selectedDate = DateTime.now();
  late RegisterUser registerUser;

  @override
  void initState() {
    registerUser = getItInstance<RegisterUser>();
    super.initState();
  }

  @override
  void dispose() {
    _displayName.dispose();
    _aadhaarController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _insuranceNumberController.dispose();
    _heartController.dispose();
    _allergyController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
              child: _signUp(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUp() {
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
            //SIGNUP TEXT
            Container(
              padding: const EdgeInsets.only(bottom: 50),
              child: Text(
                AppString.signUp,
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //NAME
            TextFormField(
              focusNode: f1,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.name,
              controller: _displayName,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.name,
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
                if (value!.isEmpty) return AppString.nameError;
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //Aadhaar Number
            TextFormField(
              focusNode: f2,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.number,
              controller: _aadhaarController,
              maxLength: 12,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                counterText: '',
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.aadhaar,
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
                  return AppString.enterAadhaarNumber;
                } else if (value.length < 12) {
                  return AppString.errorAadhaarNumber;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //DOB
            Container(
              alignment: Alignment.center,
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextFormField(
                    focusNode: f3,
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
                      hintText: 'Date Of Birth',
                      hintStyle: GoogleFonts.lato(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    controller: _dobController,
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
              height: 25.0,
            ),
            //GENDER
            DropdownButtonFormField(
              focusNode: f4,
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
                gender = gen as String;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //ADDRESS
            TextFormField(
              focusNode: f5,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.streetAddress,
              controller: _addressController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.address,
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
                  return AppString.enterAddress;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //Blood group
            DropdownButtonFormField(
              focusNode: f6,
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              hint: Text(
                "A+",
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
              items: bloodGroups
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (bg) {
                bloodGroup = bg as String;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //Weight
            TextFormField(
              focusNode: f7,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.number,
              controller: _weightController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.weight,
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
                  return AppString.enterWeight;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //Height
            TextFormField(
              focusNode: f8,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.number,
              controller: _heightController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.height,
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
                  return AppString.enterHeight;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //Insurance Number
            TextFormField(
              focusNode: f9,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.number,
              controller: _insuranceNumberController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.insuranceNumber,
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
                  return AppString.enterInsuranceNumber;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //Heart Problem
            TextFormField(
              focusNode: f10,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.text,
              controller: _heartController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.heart,
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
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //allergy
            TextFormField(
              focusNode: f11,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.text,
              controller: _allergyController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.allergy,
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
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //Email
            TextFormField(
              focusNode: f12,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.email,
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
                  return AppString.enterEmail;
                } else if (!emailValidate(value)) {
                  return AppString.emailError;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            //Password
            TextFormField(
              focusNode: f13,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              controller: _passwordController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.password,
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
                  return AppString.enterPassword;
                } else if (value.length < 8) {
                  return AppString.passwordError;
                } else {
                  return null;
                }
              },
              obscureText: true,
            ),
            const SizedBox(
              height: 25.0,
            ),
            //confirm Password
            TextFormField(
              focusNode: f14,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              controller: _passwordConfirmController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: AppString.confirmPassword,
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
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppString.enterPassword;
                } else if (value.compareTo(_passwordController.text) != 0) {
                  return AppString.confirmPasswordError;
                } else {
                  return null;
                }
              },
              obscureText: true,
            ),
            Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    AppString.signUp,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoaderDialog(context);
                      _registerAccount();
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
            Container(
              padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              child: const Divider(
                thickness: 1.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppString.alreadyAccount,
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () => _pushPage(context, RouteList.loginScreen),
                    child: Text(
                      AppString.signIn,
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: Colors.indigo[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Navigator.pop(context);
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).requestFocus(f2);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Error!",
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Email already Exists",
        style: GoogleFonts.lato(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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

  bool emailValidate(String email) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  void _registerAccount() async {
    final user = await registerUser(UserRegisterParam(
        _displayName.text,
        _aadhaarController.text,
        _addressController.text,
        _dobController.text,
        gender,
        bloodGroup,
        _weightController.text,
        _heightController.text,
        _insuranceNumberController.text,
        _heartController.text,
        _allergyController.text,
        _emailController.text,
        _passwordController.text));
    user.fold((l) {
      if (l.appErrorType == AppErrorType.userExist) {
        showAlertDialog(context);
      }
    }, (r) {
      _pushPage(context, RouteList.loginScreen);
    });
  }

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
            _dobController.text = formattedDate;
          },
        );
      },
    );
  }

  void requestFocus() {
    if (_displayName.text.isEmpty) {
      lastNode = f1;
      FocusScope.of(context).requestFocus(f1);
    } else if (_aadhaarController.text.isEmpty) {
      lastNode = f2;
      FocusScope.of(context).requestFocus(f2);
    } else if (_dobController.text.isEmpty) {
      lastNode = f3;
      FocusScope.of(context).requestFocus(f3);
    } else if (gender.isEmpty) {
      lastNode = f4;
      FocusScope.of(context).requestFocus(f4);
    } else if (_addressController.text.isEmpty) {
      lastNode = f5;
      FocusScope.of(context).requestFocus(f5);
    } else if (bloodGroup.isEmpty) {
      lastNode = f6;
      FocusScope.of(context).requestFocus(f6);
    } else if (_weightController.text.isEmpty) {
      lastNode = f7;
      FocusScope.of(context).requestFocus(f7);
    } else if (_heightController.text.isEmpty) {
      lastNode = f8;
      FocusScope.of(context).requestFocus(f8);
    } else if (_insuranceNumberController.text.isEmpty) {
      lastNode = f9;
      FocusScope.of(context).requestFocus(f9);
    } else if (_heartController.text.isEmpty) {
      lastNode = f10;
      FocusScope.of(context).requestFocus(f10);
    } else if (_allergyController.text.isEmpty) {
      lastNode = f11;
      FocusScope.of(context).requestFocus(f11);
    } else if (_emailController.text.isEmpty) {
      lastNode = f12;
      FocusScope.of(context).requestFocus(f12);
    } else if (_passwordController.text.isEmpty) {
      lastNode = f13;
      FocusScope.of(context).requestFocus(f13);
    } else if (_passwordConfirmController.text.isEmpty) {
      lastNode = f14;
      FocusScope.of(context).requestFocus(f14);
    }
  }

  void _pushPage(BuildContext context, String page) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      page,
      (_) => false,
    );
  }
}
