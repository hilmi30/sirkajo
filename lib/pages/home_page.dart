import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirkajo/models/sewa_model.dart';
import 'package:sirkajo/network/api_repo.dart';
import 'package:sirkajo/pages/daftar_page.dart';
import 'package:sirkajo/pages/lantai_page.dart';
import 'package:sirkajo/pages/keluhan_page.dart';
import 'package:sirkajo/pages/login_page.dart';
import 'package:sirkajo/pages/tagihan_page.dart';
import 'package:sirkajo/pages/tentang_kami_page.dart';
import 'package:sirkajo/services/SharePref.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Data dataSewa;

  @override
  void initState() {
    super.initState();
    getSewa();
  }

  void getSewa() {
    EasyLoading.show(
        status: 'Mohon Tunggu',
        maskType: EasyLoadingMaskType.black
    );
    EasyLoading.removeAllCallbacks();
    ApiRepo().getSewa().then((data) {
      EasyLoading.dismiss();
      if (data != null) {
        setState(() {
          dataSewa = data.data;
        });
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Terjadi Kesalahan"),
              content: Text("Silahkan Coba Lagi"),
              actions: [
                FlatButton(
                  child: Text("Coba Lagi"),
                  onPressed: () {
                    getSewa();
                  },
                )
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget item(String img, String title, int id) {
      return GestureDetector(
        onTap: () {
          switch (id) {
            // case 1: {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => DaftarPage()),
            //   );
            // }
            // break;
            case 2: {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TagihanPage()),
              );
            }
            break;
            case 3: {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KeluhanPage(idSewa: dataSewa.id,)),
              );
            }
            break;
            case 4: {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LantaiPage()),
              );
            }
            break;
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0)
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  child: Image.asset('assets/img/$img.png', width: 50, height: 50,),
                ),
                Expanded(
                    child: Text(title, textAlign: TextAlign.center, style: TextStyle(
                        fontSize: 20
                    ),)
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget itemList(String text1, String text2) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
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
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Pengaturan', 'Tentang Kami', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // item('daftar', 'Daftar', 1),
            item('pintu', 'Cek Kamar', 4),
            item('tagihan', 'Cek Tagihan', 2),
            item('keluhan', 'Keluhan', 3),

            (dataSewa != null) ? Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 16,),
                  Center(child: Text('Data Kamar', style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),)),
                  SizedBox(height: 16,),
                  itemList('Tanggal Sewa', dataSewa.attributes.tanggalSewa ?? '-'),
                  itemList('Kode Kamar', dataSewa.attributes.kodeKamar ?? '-'),
                  itemList('Lantai', dataSewa.attributes.lantai ?? '-'),
                  itemList('Pemilik', dataSewa.attributes.pemilik ?? '-'),
                  itemList('Kategori Kamar', dataSewa.attributes.kategoriKamar ?? '-'),
                  itemList('Harga Sewa', 'Rp. ${dataSewa.attributes.hargaSewa ?? '-'}/${dataSewa.attributes.satuan ?? '-'}'),
                ],
              )
            ) : SizedBox(height: 0,)
          ],
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        SharePref().hapusSharefPref();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage()
            ),
            ModalRoute.withName("/login")
        );

        break;
      case 'Tentang Kami':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TentangKamiPage(),
          ),
        );
        break;
      case 'Settings':
        break;
    }
  }
}
