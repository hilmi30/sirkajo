import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirkajo/models/tagihan_model.dart';
import 'package:sirkajo/network/api_repo.dart';
import 'package:intl/intl.dart';

class TagihanPage extends StatefulWidget {
  @override
  _TagihanPageState createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {

  Future<TagihanModel> futureTagihan;
  final cur = new NumberFormat("#,##0", "id_ID");

  @override
  void initState() {
    super.initState();
    futureTagihan = ApiRepo().getTagihan();
  }

  @override
  void deactivate() {
    super.deactivate();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {

    Widget item(String text1, String text2) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
        title: Text('Cek Tagihan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text('Tagihan Bulan Ini', style: TextStyle(
                fontSize: 20
              ),),
            ),
            SizedBox(height: 16.0,),
            FutureBuilder<TagihanModel>(
              future: futureTagihan,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        item('Kamar', '${snapshot.data.data.kodeBlok} ${snapshot.data.data.lantai} '
                            'No ${snapshot.data.data.kodeKamar}' ?? '-'),
                        item('Harga Sewa', 'Rp. ${cur.format(int.parse(snapshot.data.data.hargaSewa)) ?? '-'}'
                            '/${snapshot.data.data.satuan ?? '-'}'),
                        // item('Status', snapshot.data.message ?? '-'),
                        Text('Status'),
                        SizedBox(height: 16,),
                        Text(snapshot.data.message.toString().toUpperCase() ?? '-', style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),)
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        item('Kamar', '-'),
                        item('Harga Sewa', '-'),
                        Text('Status')
                      ],
                    );
                  }
                } else if (snapshot.hasError) {
                  Center(
                    child: Column(
                      children: [
                        Text("Terjadi Kesalahan", textAlign: TextAlign.center,),
                        SizedBox(height: 8,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              futureTagihan = ApiRepo().getTagihan();
                            });
                          },
                          child: Text("Coba Lagi", textAlign: TextAlign.center, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),),
                        ),
                      ],
                    ),
                  );
                }
                // By default, show a loading spinner.
                return Center(child: CircularProgressIndicator());
              },
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Note : pembayaran dilakukan maksimal tanggal 10 pada bulan tersebut'),
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
