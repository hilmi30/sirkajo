import 'package:flutter/material.dart';
import 'package:sirkajo/models/lantai_model.dart';
import 'package:sirkajo/network/api_repo.dart';
import 'package:sirkajo/pages/kamar_page.dart';

class LantaiPage extends StatefulWidget {
  @override
  _LantaiPageState createState() => _LantaiPageState();
}

class _LantaiPageState extends State<LantaiPage> {

  Future<LantaiModel> futureLantai;

  @override
  void initState() {
    super.initState();
    futureLantai = ApiRepo().getLantai();
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
                Text('$text2 Kamar', style: TextStyle(
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
        title: Text('Pilih Lantai'),
      ),
      body: SafeArea(
        child: FutureBuilder<LantaiModel>(
          future: futureLantai,
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
                            builder: (context) => KamarPage(lantai: snapshot.data.data[index].attributes.lantai),
                          ),
                        );
                      },
                      child: item(snapshot.data.data[index].attributes.lantai.toString(),
                          snapshot.data.data[index].attributes.kamarTersedia.toString()),
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
                          futureLantai = ApiRepo().getLantai();
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
