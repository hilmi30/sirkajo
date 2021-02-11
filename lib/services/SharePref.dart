import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirkajo/models/login_model.dart';

class SharePref {
  void simpanLogin(LoginModel login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString('token', '1');
    prefs.setString('id', login.message.id);
    prefs.setString('email', login.message.email);
    prefs.setString('username', login.message.username);
    prefs.setString('fullname', login.message.fullname);
    prefs.setString('phone', login.message.phone);
  }

  void hapusSharefPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
