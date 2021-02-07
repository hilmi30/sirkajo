import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirkajo/models/kamar_model.dart';
import 'package:sirkajo/models/lantai_model.dart';
import 'package:sirkajo/models/login_model.dart';
import 'package:sirkajo/models/register_model.dart';
import 'package:sirkajo/models/sewa_model.dart';
import 'package:sirkajo/models/tagihan_model.dart';
import 'package:sirkajo/models/tambah_sewa_model.dart';
import 'package:sirkajo/models/tentang_kami_model.dart';
import 'package:sirkajo/services/SharePref.dart';
import 'package:path/path.dart';

class ApiRepo {
  final _baseUrl = "https://polar-badlands-80162.herokuapp.com/api/v1";

  Future<bool> register(RegisterModel registerModel) async {
    var response = await http.post(
        "$_baseUrl/users",
        body: {
          'username': registerModel.username,
          'email': registerModel.email,
          'password': registerModel.password,
          'pass_confirm': registerModel.passConfirm,
          'fullname': registerModel.fullName,
          'phone': registerModel.phone,
        },
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8")
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<LoginModel> login(String login, String pass) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(
        "$_baseUrl/users/login",
        body: {
          'login': login,
          'password': pass,
          'token_fcm': prefs.getString('fcmToken') ?? ''
        },
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8")
    );

    if (response.statusCode == 200) {
      var login = LoginModel.fromJson(jsonDecode(response.body));
      SharePref().simpanLogin(login);
      return login;
    } else {
      return null;
    }
  }

  Future<TagihanModel> getTagihan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id');

    var response = await http.get(
        "$_baseUrl/tagihan/$id"
    );

    if (response.statusCode == 200) {
      return TagihanModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<LantaiModel> getLantai() async {
    var response = await http.get(
        "$_baseUrl/lantai"
    );

    if (response.statusCode == 200) {
      return LantaiModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<KamarModel> getKamar(String lantai) async {
    var response = await http.get(
        "$_baseUrl/kamar?lantai=$lantai"
    );

    if (response.statusCode == 200) {
      return KamarModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<int> tambahSewa(String idKamar) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(
        "$_baseUrl/sewa/${prefs.getString('id')}",
        body: {
          'id_kamar': idKamar
        },
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8")
    );

    return response.statusCode;
  }

  Future<TentangKamiModel> getTentangKami() async {
    var response = await http.get(
        "$_baseUrl/tentang"
    );

    if (response.statusCode == 200) {
      return TentangKamiModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<SewaModel> getSewa() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id');

    var response = await http.get(
        "$_baseUrl/sewa/$id"
    );

    if (response.statusCode == 200) {
      return SewaModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<bool> tambahKeluhan(String idSewa, keluhan, File foto) async {

    print(foto.path);

    var uri = Uri.parse("$_baseUrl/keluhan");
    var length = await foto.length();

    Map<String, String> headers = {
      "Accept": "application/json",
    };

    http.MultipartRequest request = new http.MultipartRequest('POST', uri)
      ..fields['id_sewa'] = idSewa
      ..fields['isi_keluhan'] = keluhan
      ..headers.addAll(headers)
      ..files.add(
        // replace file with your field name exampe: image
        http.MultipartFile('foto', foto.openRead(), length,
            filename: '${basename(foto.path)}'),
      );


    var respons = await http.Response.fromStream(await request.send());

    if (respons.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id');

    var response = await http.get(
        "$_baseUrl/users/logout/$id"
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}