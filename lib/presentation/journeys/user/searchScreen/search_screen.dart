import 'package:doctor_appointment/di/get_it.dart';
import 'package:doctor_appointment/presentation/journeys/user/searchScreen/search_doctor_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/doctor_entity.dart';
import '../../../../domain/usecases/get_doctors_search.dart';
import 'search_arg.dart';
import 'search_error_widget.dart';

class SearchScreen extends StatefulWidget {
  final SearchArg searchArg;

  const SearchScreen({Key? key, required this.searchArg}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isError = false;
  bool isLoading = true;
  List<DoctorEntity> docs = List.empty(growable: true);
  late GetDoctorsSearch getDoctorsSearch;

  @override
  void initState() {
    getDoctorsSearch = getItInstance<GetDoctorsSearch>();
    _getDoctor(widget.searchArg.searchKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : !isError && docs.isEmpty
                ? const SearchErrorWidget()
                : !isError
                    ? SearchDoctorList(
                        docs: docs,
                        loginEntity: widget.searchArg.loginEntity,
                      )
                    : const SearchErrorWidget(),
      ),
    );
  }

  void _getDoctor(String searchKey) async {
    final doctors = await getDoctorsSearch(searchKey);
    doctors.fold((l) {
      setState(() {
        isError = true;
        isLoading = false;
      });
    }, (r) {
      setState(() {
        docs = r;
        isLoading = false;
      });
    });
  }
}
