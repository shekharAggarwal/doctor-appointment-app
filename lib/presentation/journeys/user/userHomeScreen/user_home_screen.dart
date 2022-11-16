import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:doctor_appointment/data/models/cardModel.dart';
import 'package:doctor_appointment/domain/entities/login_entity.dart';
import 'package:doctor_appointment/presentation/journeys/user/searchScreen/search_arg.dart';
import 'package:doctor_appointment/presentation/journeys/user/userHomeScreen/explore_arg.dart';
import 'package:doctor_appointment/presentation/journeys/user/userHomeScreen/top_rated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'check_disease_banner.dart';

class UserHomeScreen extends StatefulWidget {
  final LoginEntity loginEntity;

  const UserHomeScreen({Key? key, required this.loginEntity}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  TextEditingController _doctorName = TextEditingController();
  late String _message;

  @override
  void initState() {
    super.initState();
    _doctorName = TextEditingController();
  }

  @override
  void dispose() {
    _doctorName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String _currentHour = DateFormat('kk').format(now);
    int hour = int.parse(_currentHour);

    setState(
      () {
        if (hour >= 5 && hour < 12) {
          _message = 'Good Morning';
        } else if (hour >= 12 && hour <= 17) {
          _message = 'Good Afternoon';
        } else {
          _message = 'Good Evening';
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _message,
          style: GoogleFonts.lato(
            color: Colors.black54,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Column(
              children: [
                //TEXTVIEW
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, bottom: 10, top: 30),
                  child: Text(
                    "Hello " + widget.loginEntity.userEntity!.name,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                //TEXTVIEW
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20, bottom: 25),
                  child: Text(
                    "Let's Find Your\nDoctor",
                    style: GoogleFonts.lato(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //SEARCH
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                  child: TextFormField(
                    textInputAction: TextInputAction.search,
                    controller: _doctorName,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Search doctor',
                      hintStyle: GoogleFonts.lato(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      suffixIcon: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[900]?.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          iconSize: 20,
                          splashRadius: 20,
                          color: Colors.white,
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            if (_doctorName.text.isNotEmpty) {
                              Navigator.pushNamed(
                                  context, RouteList.searchDoctor,
                                  arguments: SearchArg(
                                      widget.loginEntity, _doctorName.text));
                            }
                          },
                        ),
                      ),
                    ),
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    onFieldSubmitted: (String value) {
                      if (value.isNotEmpty) {
                        Navigator.pushNamed(context, RouteList.searchDoctor,
                            arguments: value);
                      }
                    },
                  ),
                ),
                //TEXTVIEW
                Container(
                  padding: const EdgeInsets.only(left: 23, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "We care for you",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                //BANNER
                const CheckDiseaseBanner(),
                //TEXTVIEW
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Specialists",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                //DISEASE NAME LIST
                Container(
                  height: 160,
                  padding: const EdgeInsets.only(top: 14, bottom: 30),
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 14, bottom: 10),
                        height: 150,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(cards[index].cardBackground),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 4.0,
                                spreadRadius: 0.0,
                                offset: const Offset(3, 3),
                              ),
                            ]),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteList.userDoctorByTypeScreen,
                                arguments: ExploreArg(
                                    widget.loginEntity, cards[index].doctor));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 29,
                                  child: Icon(
                                    cards[index].cardIcon,
                                    size: 26,
                                    color: Color(cards[index].cardBackground),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  cards[index].doctor,
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                //TEXTVIEW
                Container(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Doctors",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                //DOCTORS LIST
                Container(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: TopRatedList(
                    loginEntity: widget.loginEntity,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
