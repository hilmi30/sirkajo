import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirkajo/models/tagihan_model.dart';
import 'package:sirkajo/network/api_repo.dart';

class TagihanPage extends StatefulWidget {
  @override
  _TagihanPageState createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {

  Future<TagihanModel> futureTagihan;

  @override
  void initState() {
    super.initState();
    futureTagihan = ApiRepo().getTagihan();
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
                  if (snapshot.data.data.isNotEmpty) {
                    return Column(
                      children: [
                        item('Penyewa', snapshot.data.data[0].attributes.penyewa ?? '-'),
                        item('Tanggal Sewa', snapshot.data.data[0].attributes.tanggalSewa ?? '-'),
                        item('Kode Kamar', snapshot.data.data[0].attributes.kodeKamar ?? '-'),
                        item('Lantai', snapshot.data.data[0].attributes.lantai ?? '-'),
                        item('Pemilik', snapshot.data.data[0].attributes.pemilik ?? '-'),
                        item('Harga Sewa', 'Rp. ${snapshot.data.data[0].attributes.hargaSewa ?? '-'}'
                            '/${snapshot.data.data[0].attributes.satuan ?? '-'}'),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        item('Penyewa', '-'),
                        item('Tanggal Sewa', '-'),
                        item('Kode Kamar', '-'),
                        item('Lantai', '-'),
                        item('Pemilik', '-'),
                        item('Harga Sewa', '-'),
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
