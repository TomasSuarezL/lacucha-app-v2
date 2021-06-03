import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacucha_app_v2/bloc/mesociclo/bloc.dart';
import 'package:lacucha_app_v2/constants.dart';

import 'package:lacucha_app_v2/models/ejercicio_x_bloque.dart';
import 'package:lacucha_app_v2/models/bloque.dart';
import 'package:lacucha_app_v2/pages/train/editar_ejercicio.dart';
import 'package:url_launcher/url_launcher.dart';

class BloqueCard extends StatelessWidget {
  const BloqueCard({
    Key key,
    this.bloque,
    this.sesionFinalizada = false,
  }) : super(key: key);

  final Bloque bloque;
  final bool sesionFinalizada;

  void onTapVideo(BuildContext context, EjercicioXBloque ejercicio) async {
    if (ejercicio.ejercicio.urlVideo == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber[600],
          content: Text("Estamos trabajando en el video de ${ejercicio.ejercicio.nombre} !")));
      return;
    }
    if (await canLaunch(ejercicio.ejercicio.urlVideo)) {
      await launch(ejercicio.ejercicio.urlVideo);
      return;
    } else {
      throw 'Could not launch ${ejercicio.ejercicio.urlVideo}';
    }
  }

  void onTapEdit(BuildContext context, int numEjercicio, EjercicioXBloque ejercicio) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EjercicioEditor(
          ejercicio: ejercicio,
          setEjercicio: (EjercicioXBloque ejercicio) {
            bloque.ejercicios[numEjercicio] = ejercicio;
            BlocProvider.of<MesocicloBloc>(context).add(SesionUpdated(bloque: bloque));
          },
        ),
      ),
    );
  }

  Widget bloqueHeader(BuildContext context, {int numBloque, int series}) {
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

  ejercicio(BuildContext context, {int numEjercicio, EjercicioXBloque ejercicio}) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  ejercicio.ejercicio.nombre,
                  style: Theme.of(context).textTheme.subtitle1.apply(color: secondaryColorDark),
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.video_collection),
                    color: secondaryColor,
                    onPressed: () => onTapVideo(context, ejercicio)),
                if (!sesionFinalizada)
                  IconButton(
                      icon: Icon(Icons.edit),
                      color: secondaryColor,
                      onPressed: () => onTapEdit(context, numEjercicio, ejercicio)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ejercicio.ejercicio.patron, style: Theme.of(context).textTheme.subtitle2),
              Text("Reps: ${ejercicio.repeticiones}"),
              Text("Carga: ${ejercicio.carga} Kg.")
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloque.ejercicios.sort((a, b) => a.idEjerciciosxbloque.compareTo(b.idEjerciciosxbloque));
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          child: Column(
            children: <Widget>[
              bloqueHeader(context, numBloque: bloque.numBloque, series: bloque.series),
              ...(bloque.ejercicios
                  .asMap()
                  .map((idx, e) => MapEntry(idx, ejercicio(context, numEjercicio: idx, ejercicio: e)))
                  .values
                  .toList())
            ],
          ),
        ),
      ),
    );
  }
}
