import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/constants/app_string.dart';
import '../../../../../di/get_it.dart';
import '../../../../../domain/entities/no_params.dart';
import '../../../../../domain/entities/user_admin_param.dart';
import '../../../../../domain/entities/user_entity.dart';
import '../../../../../domain/usecases/get_user_for_admin.dart';
import '../../../../../domain/usecases/update_user_by_admin.dart';
import 'user_card.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late GetUserForAdmin getUserForAdmin;
  late UpdateUserByAdmin updateUserByAdmin;
  bool isLoading = true;
  bool isError = false;
  List<UserEntity> users = List.empty(growable: true);

  @override
  void initState() {
    getUserForAdmin = getItInstance<GetUserForAdmin>();
    updateUserByAdmin = getItInstance<UpdateUserByAdmin>();
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : users.isEmpty && !isError
              ? Center(
                  child: Text(
                    'No User yet',
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                )
              : !isError
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return UserCard(
                          userEntity: users[index],
                          block: () {
                            showLoaderDialog(context);
                            _updateUser(users[index].email, false, index);
                          },
                        );
                      },
                      itemCount: users.length)
                  : Center(
                      child: Text(
                        'Error while getting Users',
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
    );
  }

  void getUsers() async {
    final user = await getUserForAdmin(NoParams());
    user.fold((l) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
          isError = true;
        });
      });
    }, (r) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        users = r;
        setState(() {
          isLoading = false;
          isError = false;
        });
      });
    });
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

  void _updateUser(String email, bool isApproved, int index) async {
    final isDone = await updateUserByAdmin(UserAdminParam(
      email: email,
      isApproved: isApproved,
    ));
    Navigator.pop(context);
    isDone.fold((l) => false, (r) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          users.removeAt(index);
        });
      });
    });
  }
}
