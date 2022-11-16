import 'package:doctor_appointment/data/core/api_client.dart';
import 'package:doctor_appointment/data/core/email_exist_exception.dart';
import 'package:doctor_appointment/data/models/doctor_model.dart';
import 'package:doctor_appointment/data/models/login_model.dart';
import 'package:doctor_appointment/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<LoginModel> loginUser(String email, String password);

  Future<UserModel> registerUser(
      String name,
      String aadhaarNumber,
      String address,
      String dob,
      String gender,
      String bloodGroup,
      String weight,
      String height,
      String insuranceNumber,
      String? heartProblem,
      String? allergy,
      String email,
      String password);

  Future<DoctorModel> registerDoctor(String name, String specialization,
      String address, String email, String password);

  Future<UserModel> getUser(String email);
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final ApiClient _client;

  AuthenticationRemoteDataSourceImpl(this._client);

  @override
  Future<LoginModel> loginUser(String email, String password) async {
    try {
      final user = await _client.postData("/login", params: {
        'email': email,
        'password': password,
      });
      return LoginModel.fromJson(user);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserModel> registerUser(
      String name,
      String aadhaarNumber,
      String address,
      String dob,
      String gender,
      String bloodGroup,
      String weight,
      String height,
      String insuranceNumber,
      String? heartProblem,
      String? allergy,
      String email,
      String password) async {
    try {
      final user = await _client.postData("/registerUser", params: {
        'name': name,
        'dob': dob,
        'aadhaarNumber': aadhaarNumber,
        'address': address,
        'gender': gender,
        'bloodGroup': bloodGroup,
        'weight': weight,
        'height': height,
        'insuranceNumber': insuranceNumber,
        'heartProblem': heartProblem,
        'allergy': heartProblem,
        'email': email,
        'password': password,
      });
      return UserModel.fromJson(
          user["userTable"], user["userTable"]["id"].toString());
    } catch (error) {
      if (error
          .toString()
          .contains("could not execute statement; SQL [n/a];")) {
        throw EmailExistException();
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<UserModel> getUser(String email) async {
    try {
      final res =
          await _client.postData("/getUserByEmail", params: {"email": email});
      return UserModel.fromJson(res, res["id"].toString());
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<DoctorModel> registerDoctor(String name, String specialization,
      String address, String email, String password) async {
    try {
      if (!name.startsWith("Dr.")) {
        name = "Dr. " + name;
      }
      final doctor = await _client.postData("/registerDoctor", params: {
        'name': name,
        'degree': specialization,
        'address': address,
        'email': email,
        'password': password,
      });
      return DoctorModel.fromJson(
          doctor["doctorTable"], doctor["doctorTable"]["id"].toString());
    } catch (error) {
      if (error
          .toString()
          .contains("could not execute statement; SQL [n/a];")) {
        throw EmailExistException();
      } else {
        rethrow;
      }
    }
  }
}
