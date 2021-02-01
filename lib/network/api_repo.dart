import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sirkajo/models/login_model.dart';
import 'package:sirkajo/models/msg_model.dart';
import 'package:sirkajo/models/register_model.dart';
import 'package:sirkajo/models/tagihan_att_model.dart';
import 'package:sirkajo/services/SharePref.dart';

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
          'nik': registerModel.nik,
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

  Future<bool> login(String login, String pass) async {
    var response = await http.post(
        "$_baseUrl/users/login",
        body: {
          'login': login,
          'password': pass,
        },
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8")
    );

    if (response.statusCode == 200) {
      var login = MessageModel.fromJson(jsonDecode(response.body)['message']);
      SharePref().simpanLogin(login);
      return true;
    } else {
      return false;
    }
  }

  Future<TagihanAttModel> getTagihan(String id) async {
    var response = await http.get(
        "$_baseUrl/tagihan/$id"
    );

    if (response.statusCode == 200) {
      return TagihanAttModel.fromJson(jsonDecode(response.body)['data'][0]['attributes']);
    } else {
      return null;
    }
  }
}