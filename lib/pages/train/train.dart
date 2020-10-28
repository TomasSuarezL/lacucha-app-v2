import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/constants.dart';

import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:lacucha_app_v2/pages/train/components/bloque_card.dart';
import 'package:lacucha_app_v2/services/train_service.dart';

class TrainPage extends StatefulWidget {
  TrainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TrainPageState createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {
  Future<Sesion> futureSesion;

  Widget trainContent(sesion) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: secondaryColorDark,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Sesión de hoy.",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .apply(color: secondaryColorLight),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: sesion.bloques.length,
              itemBuilder: (BuildContext context, int index) {
                return BloqueCard(bloque: sesion.bloques[index]);
              }),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    futureSesion = TrainService.getSesion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<Sesion>(
          future: futureSesion,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return trainContent(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Empezar',
        child: Icon(
          Icons.play_arrow,
          color: Colors.green[200],
        ),
        backgroundColor: Colors.green[600],
      ),
    );
  }
}
