import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sirkajo/network/api_repo.dart';
import 'package:sirkajo/services/text_helper.dart';

class KeluhanPage extends StatefulWidget {

  final String idSewa;

  KeluhanPage({
    Key key,
    @required this.idSewa,
  }) : super(key: key);

  @override
  _KeluhanPageState createState() => _KeluhanPageState();
}

class _KeluhanPageState extends State<KeluhanPage> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController keluhanController = TextEditingController();
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keluhan'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Tulis keluhan',
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
                  controller: keluhanController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  autocorrect: false,
                  validator: (val) => TextHelper().validateRequired(val, 'Keluhan'),
                ),
                SizedBox(height: 16.0,),
                _image != null
                    ?
                Container(
                    width: 300,
                    height: 300,
                    child: Image.file(_image, fit: BoxFit.contain,)
                )
                    :
                SizedBox(height: 0,),
                SizedBox(height: 16.0,),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                      child: Text('Ambil Foto'),
                      onPressed: () {
                        getImage();
                      }
                  ),
                ),
                SizedBox(height: 16.0,),
                RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                    child: Text('Kirim'),
                    onPressed: () {
                      var formState = _key.currentState;
                      if (formState.validate()) {
                        EasyLoading.show(
                          status: 'Mohon Tunggu',
                          maskType: EasyLoadingMaskType.black
                        );
                        EasyLoading.removeAllCallbacks();
                        ApiRepo().tambahKeluhan(widget.idSewa, keluhanController.text, _image).then((status) {
                          EasyLoading.dismiss();
                          if (status) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Sukses"),
                                  content: Text("Data berhasil dikirim"),
                                  actions: [
                                    FlatButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Terjadi Kesalahan"),
                                  content: Text("Data gagal dikirim. Silahkan coba lagi"),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
