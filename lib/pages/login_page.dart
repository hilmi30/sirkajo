import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sirkajo/network/api_repo.dart';
import 'package:sirkajo/pages/register_page.dart';
import 'package:sirkajo/services/text_helper.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _obscurePassword;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 50,),
            Image.asset('assets/img/home.png', width: 100, height: 100,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text('Selamat Datang di Sistem Informasi Rusunawa Kyai Mojo Jobokuto Jepara',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),),
            ),
            SizedBox(height: 50.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Silahkan ketik Username/Email dan Password anda untuk masuk',
                textAlign: TextAlign.center,
                style: TextStyle(

                ),),
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username/Email',
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
              validator: (val) => TextHelper().validateRequired(val, 'Username/Email'),
            ),
            SizedBox(height: 12,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
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
              obscureText: _obscurePassword,
              controller: _passwordController,
              validator: (val) => TextHelper().validateRequired(val, 'Password'),
            ),
            SizedBox(height: 16,),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                child: Text('Login'),
                onPressed: _validateFormAndLogin
            ),
            SizedBox(height: 32,),
            Text('Lupa Password', textAlign: TextAlign.center, style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 16,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Register', textAlign: TextAlign.center, style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue
              )),
            )
          ],
        ),
      ),
    );
  }

  void _validateFormAndLogin() {

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
      ApiRepo().login(_emailController.text, _passwordController.text).then((data) {
        EasyLoading.dismiss();
        if (data != null && data.status == 200) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/home', ModalRoute.withName('/home'));
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Kesalahan"),
                content: Text("Username atau password salah"),
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
