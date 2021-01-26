import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/bloque.dart';
import 'package:lacucha_app_v2/models/ejercicio_x_bloque.dart';
import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:lacucha_app_v2/pages/nuevo_mesociclo/nuevo_editar_ejercicio.dart';

class NuevaSesionCard extends StatelessWidget {
  NuevaSesionCard({Key key, this.sesion, this.index, this.updateEjercicio}) : super(key: key);

  final Sesion sesion;
  final int index;
  final Function updateEjercicio;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Sesion $index",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(sesion.fechaEmpezado),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ]),
            ),
            ...sesion.bloques.map((b) => BloqueView(bloque: b, numSesion: index, updateEjercicio: updateEjercicio))
          ],
        ),
      ),
    );
  }
}

class BloqueView extends StatelessWidget {
  BloqueView({Key key, this.bloque, this.numSesion, this.updateEjercicio}) : super(key: key);

  final Bloque bloque;
  final int numSesion;
  final Function updateEjercicio;

  int ejercicioCount = 0;

  setEjercicio(int index, EjercicioXBloque ejercicio) {
    bloque.ejercicios[index] = ejercicio;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bloque ${bloque.numBloque}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text("Series"),
                  Container(
                    width: 50,
                    margin: EdgeInsets.only(left: 16),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(filled: true),
                      initialValue: "${bloque.series.toString()}",
                      onChanged: (value) => bloque.series = int.tryParse(value),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ...bloque.ejercicios.map((e) {
          int count = ejercicioCount;
          ejercicioCount++;
          return EjercicioXBloqueView(
            ejercicio: e,
            numEjercicio: count,
            numBloque: bloque.numBloque,
            numSesion: numSesion,
            updateEjercicio: updateEjercicio,
          );
        })
      ],
    );
  }
}

class EjercicioXBloqueView extends StatelessWidget {
  EjercicioXBloqueView(
      {Key key, this.ejercicio, this.numEjercicio, this.numBloque, this.numSesion, this.updateEjercicio});

  final EjercicioXBloque ejercicio;
  final int numEjercicio;
  final int numBloque;
  final int numSesion;
  final Function updateEjercicio;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(width: 80, child: Text(ejercicio.ejercicio.patron)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(width: 100, child: Text("${ejercicio.ejercicio.nombre}")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(width: 70, child: Text("${ejercicio.carga} Kg.")),
            ),
            SizedBox(width: 60, child: Text("${ejercicio.repeticiones} reps.")),
          ],
        ),
        decoration: BoxDecoration(
          color: secondaryColorLight.withOpacity(0.13),
          border: Border(top: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.05))),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EjercicioEditor(
              ejercicio: ejercicio,
              setEjercicio: (EjercicioXBloque ejercicio) {
                updateEjercicio(numSesion - 1, numBloque - 1, numEjercicio, ejercicio);
              },
            ),
          ),
        );
      },
    );
  }
}
