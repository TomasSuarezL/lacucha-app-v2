import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:lacucha_app_v2/models/usuario.dart';

import 'components/perfil_card.dart';
import 'components/sesion_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  static Usuario _usuario = Usuario(
      nombre: "Tomas",
      apellido: "Suarez Lissi",
      email: "tomas.sl@hotmail.com",
      username: "@tsuarezlissi",
      altura: 1.77,
      peso: 67,
      fechaNacimiento: new DateTime(1989, 8, 22),
      genero: "M",
      nivel: "Principiante",
      imgUrl:
          "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg");

  static Sesion _sesion = Sesion(idSesion: 1, fechaEmpezado: DateTime.now());

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
