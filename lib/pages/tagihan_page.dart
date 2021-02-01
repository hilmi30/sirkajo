import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sirkajo/models/tagihan_att_model.dart';
import 'package:sirkajo/network/api_repo.dart';

class TagihanPage extends StatefulWidget {
  @override
  _TagihanPageState createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {

  TagihanAttModel dataTagihan;

  @override
  void initState() {
    super.initState();
    dataTagihan = TagihanAttModel();
    getTagihan();
  }

  Future<void> getTagihan() async {
    EasyLoading.show(
      status: 'Memuat',
      maskType: EasyLoadingMaskType.black
    );
    ApiRepo().getTagihan('3').then((data) {
      EasyLoading.dismiss();
      if (data != null) {
        setState(() {
          dataTagihan = data;
        });
      } else {
        dialog('Terjadi Kesalahan', 'Silahkan coba lagi', 'Muat Ulang', 'Tutup');
      }
    });
  }

  Future dialog(String title, String content, String button1, String button2) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            FlatButton(
              child: Text(button1),
              onPressed: () {
                getTagihan();
              },
            ),
            FlatButton(
              child: Text(button2),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
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
            item('Penyewa', dataTagihan.penyewa ?? '-'),
            item('Tanggal Sewa', dataTagihan.tanggalSewa ?? '-'),
            item('Kode Kamar', dataTagihan.kodeKamar ?? '-'),
            item('Lantai', dataTagihan.lantai ?? '-'),
            // item('Keterangan Kamar', dataTagihan.keteranganKamar ?? '-'),
            item('Pemilik', dataTagihan.pemilik ?? '-'),
            item('Harga Sewa', 'Rp. ${dataTagihan.hargaSewa ?? '-'}/${dataTagihan.satuan ?? '-'}'),
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
