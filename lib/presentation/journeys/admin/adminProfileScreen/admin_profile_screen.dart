import 'package:doctor_appointment/domain/entities/login_entity.dart';
import 'package:doctor_appointment/presentation/journeys/admin/adminProfileScreen/about_admin_profile.dart';
import 'package:doctor_appointment/presentation/journeys/admin/adminProfileScreen/top_admin_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminProfileScreen extends StatefulWidget {
  final LoginEntity loginEntity;

  const AdminProfileScreen({Key? key, required this.loginEntity})
      : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _getDoctor();
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
                      TopAdminProfile(
                          name: widget.loginEntity.adminEntity!.name),
                      //about user
                      AboutAdminProfile(
                        adminEntity: widget.loginEntity.adminEntity!,
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

  void _getDoctor() async {
    if (widget.loginEntity.adminEntity == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
          isError = true;
        });
      });
    } else {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
          isError = false;
        });
      });
    }
  }
}
