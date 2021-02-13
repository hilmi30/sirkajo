import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sirkajo/network/api_repo.dart';
import 'package:sirkajo/services/text_helper.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Lupa Password'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: _buildForgotForm(),
      ),
    );
  }

  Widget _buildForgotForm() {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Masukkan email anda',
                textAlign: TextAlign.center,
                style: TextStyle(

                ),),
            ),
            SizedBox(height: 30,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
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
              ),
              controller: _emailController,
              keyboardType: TextInputType.text,
              autocorrect: false,
              validator: (val) => TextHelper().validateRequired(val, 'Email'),
            ),
            SizedBox(height: 16,),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                child: Text('Kirim Verifikasi'),
                onPressed: _validateForgot
            ),

          ],
        ),
      ),
    );
  }

  void _validateForgot() {

    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    var formState = _key.currentState;

    if (formState.validate()) {
      EasyLoading.show(
          status: 'Mohon Tunggu',
          maskType: EasyLoadingMaskType.black
      );
      ApiRepo().forgotPass(_emailController.text).then((status) {
        EasyLoading.dismiss();
        if (status == 200) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Verifikasi Berhasil Dikirim"),
                content: Text("Harap cek email anda"),
                actions: [
                  FlatButton(
                    child: Text("Tutup"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        } else if (status == 400) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Kesalahan"),
                content: Text("Email tidak terdaftar"),
                actions: [
                  FlatButton(
                    child: Text("Tutup"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Kesalahan"),
                content: Text("Silahkan coba lagi"),
                actions: [
                  FlatButton(
                    child: Text("Tutup"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        }
      });
    }
  }
}
