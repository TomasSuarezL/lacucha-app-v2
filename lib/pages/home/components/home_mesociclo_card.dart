import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lacucha_app_v2/bloc/mesociclo/bloc/mesociclo_bloc.dart';
import 'package:lacucha_app_v2/bloc/usuario/bloc.dart';
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:lacucha_app_v2/models/usuario.dart';
import 'package:lacucha_app_v2/pages/fin_mesociclo/fin_mesociclo.dart';
import 'package:lacucha_app_v2/pages/nuevo_mesociclo/nuevo_mesociclo.dart';

class HomeMesocicloCard extends StatelessWidget {
  const HomeMesocicloCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Usuario _usuario = (BlocProvider.of<UsuarioBloc>(context).state as UsuarioAuthenticated).usuario;
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  "Mesociclo",
                  style: Theme.of(context).textTheme.headline6.apply(color: secondaryColor, fontWeightDelta: 300),
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.refresh),
                    color: secondaryColor,
                    onPressed: () =>
                        BlocProvider.of<MesocicloBloc>(context).add(MesocicloFetched(idUsuario: _usuario.idUsuario))),
              ],
            ),
            Container(
              margin: EdgeInsets.all(24.0),
              child: BlocBuilder<MesocicloBloc, MesocicloState>(builder: (context, state) {
                if (state is MesocicloInitial || state is MesocicloFetching) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MesocicloSuccess) {
                  return MesocicloInfo(
                      sesionActual: state.sesionActual, mesociclo: state.mesociclo, hoyText: "Tenés una sesión.");
                } else if (state is MesocicloSesionFinal) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("${DateFormat('dd/MM/yyyy').format(state.sesionActual.fechaEmpezado)}"),
                      Text("Ya entrenaste hoy."),
                    ],
                  );
                } else if (state is MesocicloSesionProxima) {
                  return MesocicloInfo(
                      sesionActual: state.sesionActual, mesociclo: state.mesociclo, hoyText: "Hoy no te toca entrenar");
                } else if (state is MesocicloEmpty) {
                  return NuevoMesocicloInfo(usuario: _usuario);
                } else if (state is MesocicloFinal) {
                  return Container(
                    child: RaisedButton(
                        child: Text("Finalizar Mesociclo"),
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FinMesociclo(usuario: _usuario)),
                            )),
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

class NuevoMesocicloInfo extends StatelessWidget {
  const NuevoMesocicloInfo({
    Key key,
    @required Usuario usuario,
  })  : _usuario = usuario,
        super(key: key);

  final Usuario _usuario;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("No tenés generado ningún mesociclo."),
        SizedBox(
          height: 32.0,
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
  }
}

class MesocicloInfo extends StatelessWidget {
  final Mesociclo mesociclo;
  final Sesion sesionActual;
  final String hoyText;

  const MesocicloInfo({Key key, this.mesociclo, this.sesionActual, this.hoyText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            Text("Hoy", style: Theme.of(context).textTheme.overline.apply(fontSizeFactor: 1.5, fontWeightDelta: 300)),
            // Spacer(),
            Text(hoyText, style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
        SizedBox(height: 16.0),
        Column(
          children: [
            Text("Próxima Sesión",
                style: Theme.of(context).textTheme.overline.apply(fontSizeFactor: 1.5, fontWeightDelta: 300)),
            // Spacer(),
            Text(
                mesociclo.proximaSesion != null
                    ? "${DateFormat('dd/MM/yyyy').format(mesociclo.proximaSesion?.fechaEmpezado?.toLocal())}"
                    : "No quedan mas sesiones.",
                style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ],
    );
  }
}
