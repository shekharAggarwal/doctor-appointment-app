import 'package:doctor_appointment/common/constants/app_string.dart';
import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/login_param.dart';
import 'package:doctor_appointment/domain/usecases/login_user.dart';
import 'package:doctor_appointment/domain/usecases/save_login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/constants/app_image.dart';
import '../../../domain/entities/token_params.dart';
import '../../../domain/usecases/add_token.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  late LoginUser loginUser;
  late SaveLogin _saveLogin;
  late final AddToken addToken;

  @override
  void initState() {
    loginUser = getItInstance<LoginUser>();
    _saveLogin = getItInstance<SaveLogin>();
    addToken = getItInstance<AddToken>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: withEmailPassword(),
          ),
        ),
      ),
    );
  }

  Widget withEmailPassword() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppImage.docLogin,
                scale: 3.5,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                AppString.login,
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextFormField(
              focusNode: f1,
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
                f1.unfocus();
                FocusScope.of(context).requestFocus(f2);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppString.enterEmail;
                } else if (!emailValidate(value)) {
                  return AppString.emailError;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            TextFormField(
              focusNode: f2,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              //keyboardType: TextInputType.visiblePassword,
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
                f2.unfocus();
                FocusScope.of(context).requestFocus(f3);
              },
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) return AppString.enterPassword;
                return null;
              },
              obscureText: true,
            ),
            Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  focusNode: f3,
                  child: Text(
                    AppString.signIn,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoaderDialog(context);
                      _signInWithEmailAndPassword();
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
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppString.doNotHaveAcc,
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () =>
                        _pushPage(context, RouteList.userRegisterScreen),
                    child: Text(
                      AppString.signUpHere,
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

  void _signInWithEmailAndPassword() async {
    final user = await loginUser(
        LoginParam(_emailController.text, _passwordController.text));
    user.fold((l) {
      Navigator.pop(context);
      final snackBar = SnackBar(
        content: Row(
          children: const [
            Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            Text(AppString.loginError),
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }, (users) async {
      if (users.roleEntity.role == "user") {
        if (users.roleEntity.isApproved) {
          addTokenToDataBase(users.userEntity!.email);
          await _saveLogin(
              LoginParam(_emailController.text, _passwordController.text));
          Navigator.of(context).pushNamedAndRemoveUntil(
              RouteList.userHomeScreen, (Route<dynamic> route) => false,
              arguments: users);
        } else {
          Navigator.pop(context);
          final snackBar = SnackBar(
            content: Row(
              children: const [
                Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                Text(AppString.connectAdmin),
              ],
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else if (users.roleEntity.role == "doctor") {
        if (users.roleEntity.isApproved) {
          addTokenToDataBase(users.doctorEntity!.email);
          await _saveLogin(
              LoginParam(_emailController.text, _passwordController.text));
          Navigator.of(context).pushNamedAndRemoveUntil(
              RouteList.doctorHomeScreen, (Route<dynamic> route) => false,
              arguments: users);
        } else {
          Navigator.pop(context);
          final snackBar = SnackBar(
            content: Row(
              children: const [
                Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                Text(AppString.connectAdmin),
              ],
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else if (users.roleEntity.role == "admin") {
        addTokenToDataBase(users.adminEntity!.email);
        await _saveLogin(
            LoginParam(_emailController.text, _passwordController.text));
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteList.adminHomeScreen, (Route<dynamic> route) => false,
            arguments: users);
      } else {
        Navigator.pop(context);
        final snackBar = SnackBar(
          content: Row(
            children: const [
              Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              Text(AppString.connectAdmin),
            ],
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  void _pushPage(BuildContext context, String page) {
    Navigator.of(context).pushNamed(page);
  }

  Future<void> saveTokenToDatabase(String token, String email) async {
    await addToken(TokenParams(email, token));
  }

  void addTokenToDataBase(String email) async {
    String? token = await FirebaseMessaging.instance.getToken();
    await saveTokenToDatabase(token ?? "", email);
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      saveTokenToDatabase(token, email);
    });
  }
}
