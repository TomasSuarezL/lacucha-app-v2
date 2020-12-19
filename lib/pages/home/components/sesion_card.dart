import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lacucha_app_v2/bloc/sesion/bloc/sesion_bloc.dart';
import 'package:lacucha_app_v2/bloc/usuario/bloc/usuario_bloc.dart';
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/sesion.dart';

class SesionCard extends StatelessWidget {
  const SesionCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Text(
              "Sesion",
              style: Theme.of(context).textTheme.headline5.apply(color: secondaryColor),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: BlocBuilder<SesionBloc, SesionState>(builder: (context, state) {
                if (state is SesionSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("${DateFormat('dd/MM/yyyy').format(state.sesion.fechaEmpezado)}"),
                      Text("Tenés para hacer una sesión."),
                    ],
                  );
                } else if (state is SesionFinal) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("${DateFormat('dd/MM/yyyy').format(state.sesion.fechaEmpezado)}"),
                      Text("Ya entrenaste hoy."),
                    ],
                  );
                } else if (state is SesionProxima) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Hoy no te toca entrenar."),
                    ],
                  );
                } else {
                  return Text("Error al obtener datos de la sesion.");
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
