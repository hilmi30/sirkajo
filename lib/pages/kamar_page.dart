import 'package:flutter/material.dart';
import 'package:sirkajo/models/kamar_model.dart';
import 'package:sirkajo/models/lantai_model.dart';
import 'package:sirkajo/network/api_repo.dart';

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
                Text('Kamar $text1'),
                Text('$text2', style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),)
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Kamar'),
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
                    return item(
                      snapshot.data.data[index].attributes.kodeKamar.toString(),
                      'Rp. ${snapshot.data.data[index].attributes.hargaSewa.toString()}/'
                          '${snapshot.data.data[index].attributes.satuan.toString()}'
                    );
                  },
                );
              } else {
                return Container();
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
