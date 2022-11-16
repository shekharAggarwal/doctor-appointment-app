import 'package:doctor_appointment/domain/usecases/get_user.dart';
import 'package:doctor_appointment/domain/usecases/remove_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../di/get_it.dart';
import '../../../../domain/entities/login_entity.dart';
import '../../../../domain/entities/user_entity.dart';
import 'about_user_profile.dart';
import 'prescription/prescription_view.dart';
import 'top_user_profile.dart';

class UserProfile extends StatefulWidget {
  final LoginEntity loginEntity;

  const UserProfile({Key? key, required this.loginEntity}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late GetUser getUser;
  late UserEntity userEntity;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getUser = getItInstance<GetUser>();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : !isError
                ? ListView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      //image, name, logout
                      TopUserProfile(name: userEntity.name),
                      //about user
                      AboutUserProfile(userEntity: userEntity),
                      //prescription view
                      PrescriptionView(
                        email: userEntity.email,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'Error while getting Details',
                      style: GoogleFonts.lato(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
      ),
    );
  }

  void _getUser() async {
    final user = await getUser(widget.loginEntity.userEntity!.email);
    user.fold((l) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
          isError = true;
        });
      });
    }, (r) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
          isError = false;
          userEntity = r;
        });
      });
    });
  }

}
