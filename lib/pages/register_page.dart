import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sirkajo/models/register_model.dart';
import 'package:sirkajo/network/api_repo.dart';
import 'package:sirkajo/services/text_helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController namaUserController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController ktpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController ulangPassController = TextEditingController();

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {

    InputDecoration inputDecoration(String title) {
      return InputDecoration(
        labelText: title,
        filled: true,
        isDense: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Register')
      ),
      body: SafeArea(
        child: Form(
          key: _key,
          child: ListView(
            children: [
              SizedBox(height: 32,),
              Text('Silahkan mengisi form di bawah ini', textAlign: TextAlign.center,),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration('Nama Pengguna'),
                  controller: namaUserController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  validator: (val) => TextHelper().validateRequired(val, 'Nama Pengguna'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration('Nama Lengkap'),
                  controller: namaController,
                  keyboardType: TextInputType.name,
                  autocorrect: false,
                  validator: (val) => TextHelper().validateRequired(val, 'Nama'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration('No. KTP'),
                  controller: ktpController,
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  validator: (val) => TextHelper().validateRequired(val, 'No. KTP'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration('Email'),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (val) => TextHelper().validateEmail(val),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration('No. Handphone'),
                  controller: hpController,
                  keyboardType: TextInputType.phone,
                  autocorrect: false,
                  validator: (val) => TextHelper().validateRequired(val, 'No. Handphone'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration('Password'),
                  controller: passController,
                  obscureText: true,
                  autocorrect: false,
                  validator: (val) => TextHelper().validateRequired(val, 'Password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration('Ulangi Password'),
                  controller: ulangPassController,
                  obscureText: true,
                  autocorrect: false,
                  validator: (val) => TextHelper().validateRequired(val, 'Password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                    child: Text('Register'),
                    onPressed: () {
                      EasyLoading.show(
                        status: 'Mohon Tunggu',
                        maskType: EasyLoadingMaskType.black
                      );

                      var formState = _key.currentState;

                      if (formState.validate()) {
                        final reg = RegisterModel();
                        reg.username = namaUserController.text.toString();
                        reg.fullName = namaController.text.toString();
                        reg.nik = ktpController.text.toString();
                        reg.email = emailController.text.toString();
                        reg.phone = hpController.text.toString();
                        reg.password = passController.text.toString();
                        reg.passConfirm = ulangPassController.text.toString();

                        ApiRepo().register(reg).then((success) {
                          EasyLoading.dismiss();
                          if (success) {
                            Navigator.pop(context);
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Terjadi Kesalahan"),
                                  content: Text("Mohon cek data anda"),
                                  actions: [
                                    FlatButton(
                                      child: Text("Tutup"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        });
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
