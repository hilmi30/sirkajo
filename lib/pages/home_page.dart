// import 'dart:html';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirkajo/models/sewa_model.dart';
import 'package:sirkajo/network/api_repo.dart';
import 'package:sirkajo/pages/daftar_page.dart';
import 'package:sirkajo/pages/lantai_page.dart';
import 'package:sirkajo/pages/keluhan_page.dart';
import 'package:sirkajo/pages/login_page.dart';
import 'package:sirkajo/pages/setting_page.dart';
import 'package:sirkajo/pages/tagihan_page.dart';
import 'package:sirkajo/pages/tentang_kami_page.dart';
import 'package:sirkajo/services/SharePref.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  SewaModel dataSewa;
  final cur = new NumberFormat("#,##0", "id_ID");

  @override
  void initState() {
    super.initState();
    getSewa();
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  void getSewa() {
    EasyLoading.show(
        status: 'Mohon Tunggu',
        maskType: EasyLoadingMaskType.black
    );
    ApiRepo().getSewa().then((data) {
      EasyLoading.dismiss();
      setState(() {
        dataSewa = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget item(String text1, String text2) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0)
          ),
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text1),
                Text('Rp. $text2', style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),)
              ],
            ),
          ),
        ),
      );
    }

    Widget setRiwayatBayar() {

      final data = List<Widget>();

      for (var riwayat in dataSewa.data.attributes.pembayaran) {
        data.add(
            item(riwayat.tanggalBayar, cur.format(int.parse(riwayat.jumlahBayar)))
        );
      }

      return Column(children: data,);
    }

    Widget itemList(String text1, String text2) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text1),
                Text(text2, style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                  overflow: TextOverflow.ellipsis,)
              ],
            ),
            Divider(color: Colors.black,),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('SIRKAJO'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: () {
            getSewa();
          }),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Profil', 'Tentang Kami', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black54,
        onTap: (index) {
          switch (index) {
            case 0: {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LantaiPage()),
              );
            }
            break;
            case 1: {
              if (dataSewa == null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Akses Dibatasi"),
                      content: Text("Anda belum menyewa kamar"),
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

                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TagihanPage()),
              );
            }
            break;
            case 2: {
              if (dataSewa == null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Akses Dibatasi"),
                      content: Text("Anda belum menyewa kamar"),
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

                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KeluhanPage(idSewa: dataSewa.data.id,)),
              );
            }
            break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sensor_door),
            label: 'Kamar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Tagihan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Keluhan',
          ),
        ],
      ),
      body: SafeArea(
        child: dataSewa != null ? Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 16,),
                  Center(child: Text('Data Kamar', style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),)),
                  SizedBox(height: 16,),
                  itemList('Tanggal Sewa', dataSewa.data.attributes.tanggalSewa ?? '-'),
                  itemList('Kamar', '${dataSewa.data.attributes.kodeBlok} ${dataSewa.data.attributes.lantai} No '
                      '${dataSewa.data.attributes.kodeKamar}'),
                  itemList('Pemilik', dataSewa.data.attributes.pemilik ?? '-'),
                  itemList('Kategori Kamar', dataSewa.data.attributes.kategoriKamar ?? '-'),
                  itemList('Harga Sewa', 'Rp. ${cur.format(int.parse(dataSewa.data.attributes.hargaSewa)) ?? '-'}/${dataSewa.data.attributes.satuan ?? '-'}'),

                  SizedBox(height: 16,),
                  Center(child: Text('Riwayat Pembayaran', style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),)),
                  SizedBox(height: 16,),
                  (dataSewa.data.attributes.pembayaran != null) ? setRiwayatBayar() : SizedBox(height: 0,)

                ],
              )
            ),
          ],
        ) : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/img/building.png', width: 150, height: 150, fit: BoxFit.contain,),
              SizedBox(height: 16,),
              Text('Selamat Datang di\nSistem Informasi Rusunawa Kyai Mojo', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 16,),
              Text('Aplikasi ini memudahkan Anda dalam mengakses informasi seputar Rusunawa', style: TextStyle(

                ),),
            ],
          ),
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        EasyLoading.show(
          status: 'Mohon Tunggu',
          maskType: EasyLoadingMaskType.black
        );
        ApiRepo().logout().then((status) {
          if (status) {
            SharePref().hapusSharefPref();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage()
                ),
                ModalRoute.withName("/login")
            );
          }
        });

        break;
      case 'Tentang Kami':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TentangKamiPage(),
          ),
        );
        break;
      case 'Profil':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingPage(),
          ),
        );
        break;
    }
  }
}
