import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/constants.dart';

import 'package:lacucha_app_v2/models/ejercicio_x_bloque.dart';
import 'package:lacucha_app_v2/models/bloque.dart';
import 'package:url_launcher/url_launcher.dart';

class BloqueCard extends StatelessWidget {
  const BloqueCard({
    Key key,
    this.bloque,
  }) : super(key: key);

  final Bloque bloque;

  bloqueHeader(BuildContext context, {int numBloque, int series}) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Bloque $numBloque",
            style: Theme.of(context).textTheme.headline6.apply(color: secondaryColorDark),
          ),
          Text(
            "Series: $series",
            style: Theme.of(context).textTheme.subtitle1.apply(color: secondaryColorDark),
          ),
        ],
      ),
    );
  }

  ejercicio(BuildContext context, {EjercicioXBloque ejercicio}) {
    return InkWell(
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
                    ejercicio.ejercicio.nombre,
                    style: Theme.of(context).textTheme.subtitle1.apply(color: secondaryColorDark),
                  ),
                  Text(ejercicio.ejercicio.patron, style: Theme.of(context).textTheme.subtitle2)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Repeticiones: ${ejercicio.repeticiones}"), Text("Carga: ${ejercicio.carga} Kg.")],
            ),
          ],
        ),
      ),
      onTap: () async {
        if (ejercicio.ejercicio.urlVideo == null) {
          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.amber[600],
              content: Text("Estamos trabajando en el video de ${ejercicio.ejercicio.nombre} !")));
          return;
        }
        if (await canLaunch(ejercicio.ejercicio.urlVideo)) {
          await launch(ejercicio.ejercicio.urlVideo);
        } else {
          throw 'Could not launch ${ejercicio.ejercicio.urlVideo}';
        }
      },
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
              bloqueHeader(context, numBloque: bloque.numBloque, series: bloque.series),
              ...bloque.ejercicios.map((e) => ejercicio(context, ejercicio: e))
            ],
          ),
        ),
      ),
    );
  }
}
