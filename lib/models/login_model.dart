import 'package:sirkajo/models/msg_model.dart';

class LoginModel {
  int status;
  bool success;
  MessageModel msgModel;

  LoginModel({this.status, this.success, this.msgModel});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      success: json['success'],
      msgModel: json['message'],
    );
  }
}
