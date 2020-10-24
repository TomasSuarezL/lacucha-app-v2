import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lacucha_app_v2/models/Sesion.dart';

class SesionCard extends StatelessWidget {
  const SesionCard({
    Key key,
    this.sesion,
  }) : super(key: key);

  final Sesion sesion;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Text(
              "Sesion",
              style: Theme.of(context).textTheme.headline5,
            ),
            Container(
                margin: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "${DateFormat('dd/MM/yyyy').format(sesion.fechaInicio)}\nTodavía no entrenaste hoy.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            ElevatedButton(
              onPressed: null,
              child: Container(
                padding: EdgeInsets.all(24.0),
                child: Text("Iniciar Sesion"),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green[200]),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.green[600])),
            )
          ],
        ),
      ),
    );
  }
}
