import 'package:flutter/material.dart';

class KamarKosongPage extends StatefulWidget {
  @override
  _KamarKosongPageState createState() => _KamarKosongPageState();
}

class _KamarKosongPageState extends State<KamarKosongPage> {
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
                Text(text2, style: TextStyle(
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
        title: Text('Data Kamar Kosong'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            item('Lantai 1', '30 Kamar'),
            item('Lantai 2', '20 Kamar'),
            item('Lantai 3', '30 Kamar'),
            item('Lantai 4', '30 Kamar'),
            item('Lantai 5', '30 Kamar')
          ],
        ),
      ),
    );
  }
}
