import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sirkajo/network/api_repo.dart';
import 'package:sirkajo/pages/home_page.dart';
import 'package:sirkajo/services/text_helper.dart';

class DaftarPage extends StatefulWidget {

  final String idKamar;

  DaftarPage({
    Key key,
    @required this.idKamar,
  }) : super(key: key);

  @override
  _DaftarPageState createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {

  File ktpImg, kkImg, suratNikahImg;
  final picker = ImagePicker();

  Future getImage(ImageSource source, String id) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        switch (id) {
          case 'ktp': {
             setState(() {
               ktpImg = File(pickedFile.path);
             });
          }
          break;
          case 'kk' : {
            setState(() {
              kkImg = File(pickedFile.path);
            });
          }
          break;
          case 'suratNikah': {
            setState(() {
              suratNikahImg = File(pickedFile.path);
            });
          }
          break;
        }
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.idKamar);
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {

    void alert(String id) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Pilih Gambar"),
            actions: [
              // FlatButton(
              //   child: Text("Camera"),
              //   onPressed: () {
              //     getImage(ImageSource.camera, id);
              //     Navigator.pop(context);
              //   },
              // ),
              FlatButton(
                child: Text("Pilih Foto"),
                onPressed: () {
                  getImage(ImageSource.gallery, id);
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }

    void tambahSewa() {
      Navigator.pop(context);
      EasyLoading.show(
          status: 'Mohon Tunggu',
          maskType: EasyLoadingMaskType.black
      );
      ApiRepo().tambahSewa(widget.idKamar, ktpImg, kkImg, suratNikahImg).then((status) {
        EasyLoading.dismiss();
        print(status.toString());
        if (status == 200) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Sukses'),
                content: Text("Sewa kamar berhasil"),
                actions: [
                  FlatButton(
                    child: Text("Tutup"),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                    },
                  ),
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
                title: Text("Sudah Sewa Kamar"),
                content: Text("Anda hanya bisa menyewa 1 kamar"),
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
                title: Text("Terjadi Kesalahan"),
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Sewa Kamar'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 30,),
          Center(child: Text('Silahkan lengkap data di bawah ini')),
          SizedBox(height: 30,),
          Divider(),
          ktpImg != null ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                width: 300,
                height: 300,
                child: Image.file(ktpImg, fit: BoxFit.contain,)
            ),
          ) :
              SizedBox(height: 0,),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('Pilih Foto KTP'),
                  onPressed: () {
                    alert('ktp');
                  }
              ),
            ),
          ),
          SizedBox(height: 16,),
          Divider(),
          kkImg != null ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
                width: 300,
                height: 300,
                child: Image.file(kkImg, fit: BoxFit.contain,)
            ),
          ) :
          SizedBox(height: 0,),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('Pilih Foto KK'),
                  onPressed: () {
                    alert('kk');
                  }
              ),
            ),
          ),
          SizedBox(height: 16,),
          Divider(),
          suratNikahImg != null ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
                width: 300,
                height: 300,
                child: Image.file(suratNikahImg, fit: BoxFit.contain,)
            ),
          ) :
          SizedBox(height: 0,),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 0),
            child: Container(
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('Pilih Foto Surat Nikah'),
                  onPressed: () {
                    alert('suratNikah');
                  }
              ),
            ),
          ),
          SizedBox(height: 32,),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 0),
            child: Container(
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('Kirim'),
                  onPressed: () {
                    if (ktpImg == null || kkImg == null || suratNikahImg == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Terjadi Kesalahan'),
                            content: Text("Data anda tidak lengkap"),
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
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Pengingat'),
                            content: Text("Yakin kirim data?"),
                            actions: [
                              FlatButton(
                                child: Text("Ya"),
                                onPressed: () {
                                  tambahSewa();
                                },
                              ),
                              FlatButton(
                                child: Text("Batal"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
