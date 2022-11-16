import 'package:doctor_appointment/data/table/login_table.dart';
import 'package:hive/hive.dart';

abstract class AppLocalDataSource {
  Future<void> saveLogin(String email, String password);

  Future<void> removeLogin();

  Future<LoginTable> getLogin();
}

class AppLocalDataSourceImpl extends AppLocalDataSource {
  @override
  Future<LoginTable> getLogin() async {
    final loginBox = await Hive.openBox("loginBox");
    if (loginBox.keys.isEmpty) throw Exception();
    final v = await loginBox.get(1);
    return v;
  }

  @override
  Future<void> removeLogin() async {
    final loginBox = await Hive.openBox("loginBox");
    final v = await loginBox.delete(1);
  }

  @override
  Future<void> saveLogin(String email, String password) async {
    final loginBox = await Hive.openBox("loginBox");
    await loginBox.put(1, LoginTable(id: 1, email: email, password: password));
  }
}
