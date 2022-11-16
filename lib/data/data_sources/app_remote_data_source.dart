import 'dart:convert';

import 'package:doctor_appointment/data/core/api_client.dart';
import 'package:doctor_appointment/data/core/no_doctor_exist_exception.dart';
import 'package:doctor_appointment/data/models/appointment_model.dart';
import 'package:doctor_appointment/data/models/doctor_model.dart';
import 'package:doctor_appointment/data/models/prescription_model.dart';
import 'package:doctor_appointment/data/models/user_for_doctor_model.dart';
import 'package:doctor_appointment/data/models/user_model.dart';

abstract class AppRemoteDataSource {
  //user
  Future<List<DoctorModel>> getDoctors();

  Future<bool> cancelAppointment(String id);

  Future<List<DoctorModel>> getDoctorsByType(String type);

  Future<List<DoctorModel>> getDoctorsSearch(String name);

  Future<List<AppointmentModel>> getAppointment(String email, bool isPending);

  Future<bool> addAppointment(
      String userEmail,
      String docEmail,
      String docName,
      String userId,
      String date,
      String time,
      String name,
      String dateTime,
      String timeOfDay);

  Future<bool> addPrescription(
    String userEmail,
    String? docEmail,
    DateTime visitDate,
    String reasonForVisit,
    String symptoms,
    String prescription,
  );

  Future<List<PrescriptionModel>> getUserPrescription(String email);

  //admin
  Future<List<DoctorModel>> getDoctorRequestForAdmin();

  Future<List<DoctorModel>> getDoctorAcceptedForAdmin();

  Future<List<DoctorModel>> getDoctorRejectedForAdmin();

  Future<List<UserModel>> getUserForAdmin();

  Future<List<UserModel>> getBlockedUserForAdmin();

  Future<bool> updateUser(String email, bool isApproved);

  Future<bool> updateDoctor(String email, bool isApproved);

  //doctor
  Future<UserForDoctorModel> getUserForDoctor(String userEmail, String uid);

  Future<bool> updateAppointment(String userEmail, String id, int status,
      String doctorName, DateTime timestamp);

  Future<List<AppointmentModel>> getDoctorRequestAppointment(String email);

  Future<List<AppointmentModel>> getDoctorTodayAppointment(String email);

  Future<List<AppointmentModel>> getDoctorCompletedAppointment(String email);

  Future<bool> addPrescriptionByDoctor(
    String userEmail,
    String appointmentId,
    String docEmail,
    DateTime visitDate,
    String reasonForVisit,
    String symptoms,
    String prescription,
  );

  Future<PrescriptionModel> getPrescription(String pId);

  //Token
  Future<bool> addToken(String email, String token);
}

class AppRemoteDataSourceImpl extends AppRemoteDataSource {
  final ApiClient _apiClient;

  AppRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<DoctorModel>> getDoctors() async {
    try {
      List<DoctorModel> doctors = List.empty(growable: true);
      final re = await _apiClient.postData("/allDoctor");
      if ((re as List).isNotEmpty) {
        for (final doctor in re) {
          doctors.add(DoctorModel.fromJson(doctor, doctor["id"].toString()));
        }
        return doctors;
      } else {
        throw NoDoctorExistException();
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<DoctorModel>> getDoctorsByType(String type) async {
    try {
      List<DoctorModel> doctors = List.empty(growable: true);
      final re = await _apiClient
          .postData("/specializationDoctor", params: {"specialization": type});
      if ((re as List).isNotEmpty) {
        for (final doctor in re) {
          doctors.add(DoctorModel.fromJson(doctor, doctor["id"].toString()));
        }
        return doctors;
      } else {
        throw NoDoctorExistException();
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> addAppointment(
      String userEmail,
      String docEmail,
      String docName,
      String userId,
      String date,
      String time,
      String name,
      String dateTime,
      String timeOfDay) async {
    try {
      await _apiClient.postData("/bookAppointment", params: {
        'userEmail': userEmail,
        'doctorEmail': docEmail,
        'doctorName': docName,
        'userId': userId,
        'userName': name,
        'appointmentTime':
            DateTime.parse(dateTime + ' ' + timeOfDay + ':00').toIso8601String()
      });
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<List<DoctorModel>> getDoctorsSearch(String name) async {
    try {
      List<DoctorModel> doctors = List.empty(growable: true);
      final re = await _apiClient.postData("/search", params: {"query": name});
      if ((re as List).isNotEmpty) {
        for (final doctor in re) {
          doctors.add(DoctorModel.fromJson(doctor, doctor["id"].toString()));
        }
        return doctors;
      } else {
        throw NoDoctorExistException();
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<AppointmentModel>> getAppointment(
      String email, bool isPending) async {
    try {
      List<AppointmentModel> appointments = List.empty(growable: true);
      if (isPending) {
        final res = await _apiClient
            .postData("/appointmentPending", params: {"email": email});
        if (res.isNotEmpty) {
          for (final appointment in res) {
            appointments.add(AppointmentModel.fromJson(
                appointment, appointment["id"].toString()));
          }
        }
      } else {
        final res = await _apiClient
            .postData("/appointmentCompleted", params: {"email": email});
        if (res.isNotEmpty) {
          for (final appointment in res) {
            appointments.add(AppointmentModel.fromJson(
                appointment, appointment["id"].toString()));
          }
        }
      }

      return appointments;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> cancelAppointment(String id) async {
    try {
      await _apiClient.postData("/updateAppointmentStatus",
          params: {"id": id, "isAccepted": 3});
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> addPrescription(
      String userEmail,
      String? docEmail,
      DateTime visitDate,
      String reasonForVisit,
      String symptoms,
      String prescription) async {
    try {
      await _apiClient.postData("/addPrescription", params: {
        "doctorEmail": docEmail,
        "userEmail": userEmail,
        "reason": reasonForVisit,
        "symptoms": symptoms,
        "prescription": prescription,
        "appointmentTime": visitDate.toIso8601String(),
      });
      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<PrescriptionModel>> getUserPrescription(String email) async {
    try {
      List<PrescriptionModel> prescriptions = List.empty(growable: true);
      final res = await _apiClient
          .postData("/prescriptionByEmail", params: {"userEmail": email});
      if (res.isNotEmpty) {
        for (final prescription in res) {
          prescriptions.add(PrescriptionModel.fromJson(
              prescription, prescription["id"].toString()));
        }
      }
      return prescriptions;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<AppointmentModel>> getDoctorRequestAppointment(
      String email) async {
    try {
      List<AppointmentModel> appointments = List.empty(growable: true);
      final res = await _apiClient.postData("/getAppointmentByStatus",
          params: {"doctorEmail": email, "isAccepted": 0});
      if (res.isNotEmpty) {
        for (final appointment in res) {
          appointments.add(AppointmentModel.fromJson(
              appointment, appointment["id"].toString()));
        }
      }
      return appointments;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<AppointmentModel>> getDoctorTodayAppointment(String email) async {
    try {
      List<AppointmentModel> appointments = List.empty(growable: true);
      final res = await _apiClient.postData("/getAppointmentByStatus",
          params: {"doctorEmail": email, "isAccepted": 1});
      if (res.isNotEmpty) {
        for (final appointment in res) {
          appointments.add(AppointmentModel.fromJson(
              appointment, appointment["id"].toString()));
        }
      }
      return appointments;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<AppointmentModel>> getDoctorCompletedAppointment(
      String email) async {
    try {
      List<AppointmentModel> appointments = List.empty(growable: true);
      final res = await _apiClient.postData("/getAppointmentByStatus",
          params: {"doctorEmail": email, "isAccepted": 2});
      if (res.isNotEmpty) {
        for (final appointment in res) {
          appointments.add(AppointmentModel.fromJson(
              appointment, appointment["id"].toString()));
        }
      }
      return appointments;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> updateAppointment(String userEmail, String id, int status,
      String doctorName, DateTime timestamp) async {
    try {
      await _apiClient.postData("/updateAppointmentStatus",
          params: {"id": id, "isAccepted": status});
      if (status == 1) {
        await sendNotification(userEmail, "Appointment Update",
            "Appointment accepted by doctor.", "scheduleNotification",
            doctor: doctorName, timestamp: timestamp);
      } else {
        await sendNotification(userEmail, "Appointment Update",
            "Appointment cancelled by doctor.", "updateNotification",
            doctor: doctorName, timestamp: timestamp);
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<UserForDoctorModel> getUserForDoctor(
      String userEmail, String uid) async {
    try {
      List<PrescriptionModel> prescriptions = List.empty(growable: true);
      final res = await _apiClient
          .postData("/prescriptionByEmail", params: {"userEmail": userEmail});
      if (res.isNotEmpty) {
        for (final prescription in res) {
          prescriptions.add(PrescriptionModel.fromJson(
              prescription, prescription["id"].toString()));
        }
      }
      final user = await _apiClient
          .postData("/getUserByEmail", params: {"email": userEmail});
      return UserForDoctorModel(
          user: UserModel.fromJson(user, user["id"].toString()),
          prescriptions: prescriptions);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> addPrescriptionByDoctor(
      String userEmail,
      String appointmentId,
      String docEmail,
      DateTime visitDate,
      String reasonForVisit,
      String symptoms,
      String prescription) async {
    try {
      await _apiClient.postData("/appointmentUpdateByDoctor", params: {
        "doctorEmail": docEmail,
        "userEmail": userEmail,
        "reason": reasonForVisit,
        "symptoms": symptoms,
        "prescription": prescription,
        "appointmentTime": visitDate.toIso8601String(),
        "appointmentId": appointmentId
      });
      await sendNotification(userEmail, "Prescription Update",
          "Prescriptions added by doctor.", "updateNotification");
      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> sendNotification(
      String userId, String title, String body, String channelId,
      {String? doctor, DateTime? timestamp}) async {
    try {
      final res =
          await _apiClient.postData("/getToken", params: {"email": userId});
      if(res !=null){
        await _apiClient.post(jsonEncode(<String, dynamic>{
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
          },
          "android": <String, dynamic>{"channelId": channelId},
          "priority": 'high',
          'data': <String, dynamic>{
            "channelId": channelId,
            "doctor": doctor ?? "",
            "time": timestamp?.millisecondsSinceEpoch.toString() ?? ""
          },
          "to": res["token"]
        }));
      }
      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<PrescriptionModel> getPrescription(String pId) async {
    try {
      final res = await _apiClient
          .postData("/appointmentDetails", params: {"appointmentId": pId});
      return PrescriptionModel.fromJson(
          res["prescriptionTable"], res["prescriptionTable"]["id"].toString());
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getBlockedUserForAdmin() async {
    try {
      List<UserModel> users = List.empty(growable: true);
      final user = await _apiClient
          .postData("/getUserByStatus", params: {"status": false});

      if (user.isNotEmpty) {
        for (final item in user) {
          users.add(UserModel.fromJson(item, item["id"].toString()));
        }
      }
      return users;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<DoctorModel>> getDoctorAcceptedForAdmin() async {
    try {
      List<DoctorModel> doctors = List.empty(growable: true);
      final res = await _apiClient.postData("/acceptedDoctor");
      if (res.isNotEmpty) {
        for (final item in res) {
          doctors.add(DoctorModel.fromJson(item, item["id"].toString()));
        }
      }
      return doctors;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<DoctorModel>> getDoctorRejectedForAdmin() async {
    try {
      List<DoctorModel> doctors = List.empty(growable: true);
      final res = await _apiClient.postData("/rejectedDoctor");
      if (res.isNotEmpty) {
        for (final item in res) {
          doctors.add(DoctorModel.fromJson(item, item["id"].toString()));
        }
      }
      return doctors;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<DoctorModel>> getDoctorRequestForAdmin() async {
    try {
      List<DoctorModel> doctors = List.empty(growable: true);
      final res = await _apiClient.postData("/pendingDoctor");
      if (res.isNotEmpty) {
        for (final item in res) {
          doctors.add(DoctorModel.fromJson(item, item["id"].toString()));
        }
      }
      return doctors;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getUserForAdmin() async {
    try {
      List<UserModel> users = List.empty(growable: true);
      final user = await _apiClient
          .postData("/getUserByStatus", params: {"status": true});

      if (user.isNotEmpty) {
        for (final item in user) {
          users.add(UserModel.fromJson(item, item["id"].toString()));
        }
      }
      return users;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> updateDoctor(String email, bool isApproved) async {
    try {
      await _apiClient.postData("/updateDoctorStatus",
          params: {"doctorEmail": email, "status": isApproved});

      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> updateUser(String email, bool isApproved) async {
    try {
      await _apiClient.postData("/changeUserStatus",
          params: {"userEmail": email, "status": isApproved});
      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> addToken(String email, String token) async {
    try {
      await _apiClient
          .postData("/addToken", params: {"email": email, "token": token});
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
