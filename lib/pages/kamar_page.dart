import 'package:flutter/material.dart';
import 'package:sirkajo/models/kamar_model.dart';
import 'package:sirkajo/network/api_repo.dart';
import 'package:sirkajo/pages/kamar_detail_page.dart';

class KamarPage extends StatefulWidget {

  final String lantai;
  KamarPage({Key key, @required this.lantai}) : super(key: key);

  @override
  _KamarPageState createState() => _KamarPageState();
}

class _KamarPageState extends State<KamarPage> {

  Future<KamarModel> futureKamar;

  @override
  void initState() {
    super.initState();
    futureKamar = ApiRepo().getKamar(widget.lantai);
  }

  @override
  Widget build(BuildContext context) {

    Widget item(String text1, text2, text3, text4) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0)
          ),
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kamar $text1', style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),),
                    Text('$text2', style: TextStyle(

                    ),)
                  ],
                ),
                Divider(color: Colors.black,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$text3'),
                    Text('$text4', style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.lantai}'),
      ),
      body: SafeArea(
        child: FutureBuilder<KamarModel>(
          future: futureKamar,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.data.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KamarDetailPage(
                              kodeKamar: snapshot.data.data[index].attributes.kodeKamar,
                              hargaSewa: snapshot.data.data[index].attributes.hargaSewa,
                              satuan: snapshot.data.data[index].attributes.satuan,
                              ketKamar: snapshot.data.data[index].attributes.keteranganKamar,
                              pemilik: snapshot.data.data[index].attributes.pemilik,
                              kategori: snapshot.data.data[index].attributes.kategoriKamar,
                              lantai: snapshot.data.data[index].attributes.lantai,
                              id: snapshot.data.data[index].id
                            ),
                          ),
                        );
                      },
                      child: item(
                        snapshot.data.data[index].attributes.kodeKamar.toString(),
                        'Rp. ${snapshot.data.data[index].attributes.hargaSewa.toString()}/'
                            '${snapshot.data.data[index].attributes.satuan.toString()}',
                        snapshot.data.data[index].attributes.kategoriKamar,
                        ''
                      ),
                    );
                  },
                );
              } else {
                return Container(width: 0.0, height: 0.0,);
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Text("Terjadi Kesalahan", textAlign: TextAlign.center,),
                    SizedBox(height: 8,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          futureKamar = ApiRepo().getKamar(widget.lantai);
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
      ),
    );
  }
}
