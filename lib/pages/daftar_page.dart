import 'package:flutter/material.dart';
import 'package:sirkajo/services/text_helper.dart';

class DaftarPage extends StatefulWidget {
  @override
  _DaftarPageState createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController ktpController = TextEditingController();
  TextEditingController kkController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

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
        title: Text('Daftar'),
      ),
      body: SafeArea(
        child: Form(
          key: _key,
          child: ListView(
            children: [
              SizedBox(height: 32,),
              Text('Silahkan isi data di bawah ini', textAlign: TextAlign.center,),
              SizedBox(height: 16,),
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
                  decoration: inputDecoration('No. KK'),
                  controller: kkController,
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  validator: (val) => TextHelper().validateRequired(val, 'No. KK'),
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
                  decoration: inputDecoration('Alamat'),
                  controller: alamatController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  validator: (val) => TextHelper().validateRequired(val, 'Alamat'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                    child: Text('Submit'),
                    onPressed: () {
                      var formState = _key.currentState;

                      if (formState.validate()) {
                        print('Form is valid');
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
