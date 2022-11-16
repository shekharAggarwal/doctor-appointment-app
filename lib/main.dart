import 'package:doctor_appointment/data/table/login_table.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'data/core/push_notification_service.dart';
import 'di/get_it.dart' as getIt;
import 'presentation/doc_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(LoginTableAdapter());
  await Firebase.initializeApp();
  await getIt.init();
  await PushNotificationService.init();
  runApp(const DocApp());
}
