import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/pages/history/components/mesociclo_card.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    //return MesocicloCard(mesociclo: null);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
