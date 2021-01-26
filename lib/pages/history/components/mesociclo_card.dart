import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';

import 'package:lacucha_app_v2/models/sesion.dart';

class MesocicloCard extends StatelessWidget {
  MesocicloCard({
    Key key,
    this.mesociclo,
  }) : super(key: key);

  final Mesociclo mesociclo;

  mesocicloHeader(BuildContext context, {int numMesociclo, DateTime fecha}) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Mesociclo $numMesociclo",
            style: Theme.of(context).textTheme.headline6.apply(color: secondaryColorDark),
          ),
          Text(
            "${DateFormat('dd/MM/yyyy').format(fecha)}",
            style: Theme.of(context).textTheme.subtitle1.apply(color: secondaryColorDark),
          ),
        ],
      ),
    );
  }

  sesion(BuildContext context, {Sesion sesion}) {
    return Ink(
      color: sesion.fechaFinalizado != null ? Colors.lightGreen[50] : null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sesion: ${sesion.idSesion}",
                    style: Theme.of(context).textTheme.subtitle1.apply(color: secondaryColorDark),
                  ),
                  Text(DateFormat('dd/MM/yyyy').format(sesion.fechaEmpezado),
                      style: Theme.of(context).textTheme.subtitle2)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Duracion: ${sesion.fechaFinalizado != null ? sesion.fechaFinalizado.difference(sesion.fechaEmpezado).inMinutes.toString() + " mins." : "Pendiente"}"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          child: Column(
            children: <Widget>[
              mesocicloHeader(context, numMesociclo: 1, fecha: DateTime.now()),
              ...mesociclo.sesiones.reversed.map((s) => sesion(context, sesion: s))
            ],
          ),
        ),
      ),
    );
  }
}
