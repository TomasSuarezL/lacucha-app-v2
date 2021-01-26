import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lacucha_app_v2/bloc/mesociclo/bloc/mesociclo_bloc.dart';
import 'package:lacucha_app_v2/bloc/usuario/bloc.dart';
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/usuario.dart';
import 'package:lacucha_app_v2/pages/nuevo_mesociclo/nuevo_mesociclo.dart';

class HomeSesionCard extends StatelessWidget {
  const HomeSesionCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Usuario _usuario = (BlocProvider.of<UsuarioBloc>(context).state as UsuarioAuthenticated).usuario;
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.all(0.0),
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
              child: BlocBuilder<MesocicloBloc, MesocicloState>(builder: (context, state) {
                if (state is MesocicloInitial || state is MesocicloFetching) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MesocicloSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("${DateFormat('dd/MM/yyyy').format(state.sesionActual.fechaEmpezado)}"),
                      Text("Tenés para hacer una sesión."),
                    ],
                  );
                } else if (state is MesocicloSesionFinal) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("${DateFormat('dd/MM/yyyy').format(state.sesionActual.fechaEmpezado)}"),
                      Text("Ya entrenaste hoy."),
                    ],
                  );
                } else if (state is MesocicloSesionProxima) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Hoy no te toca entrenar."),
                    ],
                  );
                } else if (state is MesocicloEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("No tenés generado ningún mesociclo."),
                      SizedBox(
                        height: 16.0,
                      ),
                      RaisedButton(
                        child: Text(
                          "Crear Nuevo Mesociclo",
                          style: Theme.of(context).textTheme.subtitle2.apply(color: Colors.white70),
                        ),
                        color: secondaryColorLight,
                        padding: EdgeInsets.all(16.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NuevoMesociclo(usuario: _usuario)),
                          );
                        },
                      ),
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
