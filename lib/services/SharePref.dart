import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirkajo/models/login_model.dart';
import 'package:sirkajo/models/msg_model.dart';

class SharePref {
  void simpanLogin(MessageModel login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString('token', '1');
    prefs.setString('id', login.id);
    prefs.setString('email', login.email);
    prefs.setString('username', login.username);
    prefs.setString('fullname', login.fullname);
    prefs.setString('phone', login.phone);
    prefs.setString('nokk', login.nokk);
    prefs.setString('noktp', login.noktp);
  }

  void hapusSharefPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
