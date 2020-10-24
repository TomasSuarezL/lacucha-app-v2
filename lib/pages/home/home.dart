import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/models/Sesion.dart';
import 'package:lacucha_app_v2/models/Usuario.dart';

import 'components/PerfilCard.dart';
import 'components/SesionCard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  static Usuario _usuario = Usuario(
      nombre: "Tomas Suarez Lissi",
      usuario: "@tsuarezlissi",
      avatarUrl:
          "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg");

  static Sesion _sesion = Sesion(id: 1, fechaInicio: DateTime.now());

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        child: Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PerfilCard(usuario: _usuario),
              SesionCard(sesion: _sesion)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Start',
        child: Icon(Icons.play_arrow),
        backgroundColor: Colors.green[600],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
