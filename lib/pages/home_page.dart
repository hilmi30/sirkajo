import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirkajo/pages/daftar_page.dart';
import 'package:sirkajo/pages/lantai_page.dart';
import 'package:sirkajo/pages/keluhan_page.dart';
import 'package:sirkajo/pages/login_page.dart';
import 'package:sirkajo/pages/tagihan_page.dart';
import 'package:sirkajo/services/SharePref.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    tes();
  }

  void tes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('email'));
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
                MaterialPageRoute(builder: (context) => KeluhanPage()),
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
      case 'Settings':
        break;
    }
  }
}
