import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sirkajo/models/tentang_kami_model.dart';
import 'package:sirkajo/network/api_repo.dart';

class TentangKamiPage extends StatefulWidget {
  @override
  _TentangKamiPageState createState() => _TentangKamiPageState();
}

class _TentangKamiPageState extends State<TentangKamiPage> {

  Future<TentangKamiModel> futureTentang;

  @override
  void initState() {
    super.initState();
    futureTentang = ApiRepo().getTentangKami();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Kami'),
      ),
      body: FutureBuilder<TentangKamiModel>(
        future: futureTentang,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Text('${snapshot.data.judul}', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ),
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('${snapshot.data.isi}', textAlign: TextAlign.center,),
                )
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

