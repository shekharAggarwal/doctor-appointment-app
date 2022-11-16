import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/domain/entities/no_params.dart';
import 'package:doctor_appointment/domain/entities/token_params.dart';
import 'package:doctor_appointment/domain/usecases/add_token.dart';
import 'package:doctor_appointment/domain/usecases/check_login.dart';
import 'package:doctor_appointment/domain/usecases/login_user.dart';
import 'package:doctor_appointment/domain/usecases/remove_login.dart';
import 'package:doctor_appointment/presentation/widgets/assets_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final CheckLogin _checkLogin;
  late final LoginUser _loginUser;
  late final RemoveLogin _removeLogin;
  late final AddToken _addToken;

  @override
  void initState() {
    _checkLogin = getItInstance<CheckLogin>();
    _loginUser = getItInstance<LoginUser>();
    _removeLogin = getItInstance<RemoveLogin>();
    _addToken = getItInstance<AddToken>();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _getUserAndPush();
    });
    super.initState();
  }

  void _getUserAndPush() async {
    final user = await _checkLogin(NoParams());
    user.fold((l) => _pushTo(context, RouteList.skipScreen), (r) async {
      final lo = await _loginUser(r);
      lo.fold((l) => _pushTo(context, RouteList.skipScreen), (r) async {
        if (r.roleEntity.role == "user") {
          if (r.roleEntity.isApproved) {
            addTokenToDataBase(r.userEntity!.email);
            _pushTo(context, RouteList.userHomeScreen, arg: r);
          } else {
            await _removeLogin(NoParams());
            _pushTo(context, RouteList.skipScreen);
          }
        } else if (r.roleEntity.role == "doctor") {
          if (r.roleEntity.isApproved) {
            addTokenToDataBase(r.doctorEntity!.email);
            _pushTo(context, RouteList.doctorHomeScreen, arg: r);
          } else {
            await _removeLogin(NoParams());

            _pushTo(context, RouteList.skipScreen);
          }
        } else if (r.roleEntity.role == "admin") {
          addTokenToDataBase(r.adminEntity!.email);
          _pushTo(context, RouteList.adminHomeScreen, arg: r);
        } else {
          await _removeLogin(NoParams());

          _pushTo(context, RouteList.skipScreen);
        }
      });
    });
  }

  Future<void> saveTokenToDatabase(String token, String email) async {
    await _addToken(TokenParams(email, token));
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: AssetsImage(
            "assets/logo.png",
            width: 192,
            height: 192,
          ),
        ),
      ),
    );
  }

  void _pushTo(BuildContext context, String page, {dynamic arg}) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(page, (_) => false, arguments: arg);
  }

  void addTokenToDataBase(String email) async {
    String? token = await FirebaseMessaging.instance.getToken();
    await saveTokenToDatabase(token ?? "", email);
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      saveTokenToDatabase(token, email);
    });
  }
}
