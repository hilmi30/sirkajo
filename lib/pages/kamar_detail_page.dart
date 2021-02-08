import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sirkajo/models/tambah_sewa_model.dart';
import 'package:sirkajo/network/api_repo.dart';
import 'package:sirkajo/pages/daftar_page.dart';
import 'package:intl/intl.dart';

class KamarDetailPage extends StatefulWidget {
  
  final String kodeKamar;
  final String hargaSewa;
  final String satuan;
  final String ketKamar;
  final String pemilik;
  final String kategori;
  final String lantai;
  final String id;
  final String kodeBlok;

  KamarDetailPage({
    Key key,
    @required this.kodeKamar,
    @required this.hargaSewa,
    @required this.satuan,
    @required this.ketKamar,
    @required this.pemilik,
    @required this.kategori,
    @required this.lantai,
    @required this.id,
    @required this.kodeBlok,
  }) : super(key: key);
  
  @override
  _KamarDetailPageState createState() => _KamarDetailPageState();
}

class _KamarDetailPageState extends State<KamarDetailPage> {

  final cur = new NumberFormat("#,##0", "id_ID");

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
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
        title: Text('Detail Kamar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text('${widget.kodeBlok} ${widget.lantai} No ${widget.kodeKamar}', style: TextStyle(
                  fontSize: 20
              ),),
            ),
            SizedBox(height: 16.0,),
            item('Harga Sewa', 'Rp. ${cur.format(int.parse(widget.hargaSewa))}/${widget.satuan}'),
            item('Pemilik', '${widget.pemilik}'),
            item('Kategori', '${widget.kategori}'),
            Text('Keterangan :'),
            SizedBox(height: 8,),
            Text('${widget.ketKamar}'),
            SizedBox(height: 32,),
            Container(
              width: double.infinity,
              child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('SEWA'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DaftarPage(idKamar: widget.id,)),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
