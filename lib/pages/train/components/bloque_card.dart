import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/constants.dart';

import 'package:lacucha_app_v2/models/ejercicio.dart';
import 'package:lacucha_app_v2/models/bloque.dart';

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
            style: Theme.of(context)
                .textTheme
                .headline6
                .apply(color: secondaryColorDark),
          ),
          Text(
            "Series: $series",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .apply(color: secondaryColorDark),
          ),
        ],
      ),
    );
  }

  ejercicio(BuildContext context, {Ejercicio ejercicio}) {
    return Container(
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
                  ejercicio.ejercicio,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .apply(color: secondaryColorDark),
                ),
                Text(ejercicio.patron,
                    style: Theme.of(context).textTheme.subtitle2)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Repeticiones: ${ejercicio.repeticiones}"),
              Text("Carga: ${ejercicio.carga} Kg.")
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: secondaryColor, width: 8),
            ),
          ),
          child: Column(
            children: <Widget>[
              bloqueHeader(context,
                  numBloque: bloque.numBloque, series: bloque.series),
              ...bloque.ejercicios.map((e) => ejercicio(context, ejercicio: e))
            ],
          ),
        ),
      ),
    );
  }
}
