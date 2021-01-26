import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:lacucha_app_v2/bloc/mesociclo/bloc.dart';
import 'package:lacucha_app_v2/bloc/timer/bloc.dart';
import 'package:lacucha_app_v2/bloc/usuario/bloc.dart';
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:lacucha_app_v2/pages/nuevo_mesociclo/nuevo_mesociclo.dart';
import 'package:lacucha_app_v2/pages/train/components/bloque_card.dart';
import 'package:lacucha_app_v2/pages/train/components/timer.dart';

class TrainPage extends StatefulWidget {
  TrainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TrainPageState createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {
  Future<Sesion> futureSesion;

  MesocicloBloc _sesionBloc;
  UsuarioBloc _usuarioBloc;

  @override
  void initState() {
    super.initState();
    _sesionBloc = BlocProvider.of<MesocicloBloc>(context);
    _usuarioBloc = BlocProvider.of<UsuarioBloc>(context);
  }

  Widget _sesionPendiente(Sesion sesion) {
    if (sesion.idSesion == null) {
      return Center(child: Text("No hay ninguna sesión disponible"));
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Ink(
            color: secondaryColorDark,
            child: Container(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sesión de hoy.",
                      style: Theme.of(context).textTheme.headline6.apply(color: Colors.blueGrey[200]),
                    ),
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        splashRadius: 24,
                        padding: EdgeInsets.all(0.0),
                        color: Colors.blueGrey[200],
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: sesion.bloques.length,
                itemBuilder: (BuildContext context, int index) {
                  return BloqueCard(bloque: sesion.bloques[index]);
                }),
          ),
          Container(child: Timer())
        ],
      );
    }
  }

  Widget _sesionFinalizada(Sesion sesion, int idUsuario) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Ink(
          color: Colors.green[100],
          child: Container(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sesión de hoy finalizada.",
                    style: Theme.of(context).textTheme.headline6.apply(color: Colors.green[600]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${DateFormat('dd/MM/yyyy hh:mm:ss').format(sesion.fechaEmpezado)}",
                    style: Theme.of(context).textTheme.subtitle1.apply(color: Colors.green[600]),
                  ),
                  Text(
                    "duracion: ${sesion.fechaFinalizado.difference(sesion.fechaEmpezado).inMinutes.toString()} mins.",
                    style: Theme.of(context).textTheme.subtitle1.apply(color: Colors.green[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: sesion.bloques.length,
              itemBuilder: (BuildContext context, int index) {
                return BloqueCard(bloque: sesion.bloques[index]);
              }),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Center(
            child: RaisedButton(
              child: Text(
                "Siguiente Sesion",
                style: Theme.of(context).textTheme.button.apply(color: Colors.green[600]),
              ),
              color: Colors.green[100],
              onPressed: () => _sesionBloc.add(SesionNext(idUsuario: idUsuario)),
            ),
          ),
        )
      ],
    );
  }

  Widget _sesionProxima(int idUsuario) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hoy no te toca entrenar, pero podés hacer la próxima.",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            child: Text(
              "Próxima Sesión",
              style: Theme.of(context).textTheme.headline6.apply(color: Colors.green[100]),
            ),
            padding: EdgeInsets.all(16.0),
            color: Colors.green[600],
            onPressed: () => _sesionBloc.add(SesionNext(idUsuario: idUsuario)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocBuilder<UsuarioBloc, UsuarioState>(
          builder: (usuarioContext, usuarioState) {
            return BlocConsumer<MesocicloBloc, MesocicloState>(
              listener: (context, state) {},
              builder: (sesionContext, sesionState) {
                if (usuarioState is UsuarioAuthenticated) {
                  if (sesionState is MesocicloInitial) {
                    return Center(child: CircularProgressIndicator());
                  } else if (sesionState is MesocicloFailure) {
                    return Center(child: Text("Error al obtener la próxima sesión."));
                  } else if (sesionState is MesocicloSuccess || sesionState is MesocicloSesionStart) {
                    return _sesionPendiente(sesionState.sesionActual);
                  } else if (sesionState is MesocicloSesionFinal) {
                    return _sesionFinalizada(sesionState.sesionActual, usuarioState.usuario.idUsuario);
                  } else if (sesionState is MesocicloSesionProxima) {
                    return _sesionProxima(usuarioState.usuario.idUsuario);
                  } else if (sesionState is MesocicloEmpty) {
                    return Center(child: Text("Sin Mesociclo."));
                  }
                }
                return Container();
              },
            );
          },
        ),
      ),
      floatingActionButton: BlocBuilder<MesocicloBloc, MesocicloState>(builder: (sesionContext, sesionState) {
        return BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
          if (sesionState is MesocicloSesionProxima)
            return Container();
          else if (sesionState is MesocicloEmpty) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NuevoMesociclo(usuario: ((_usuarioBloc.state) as UsuarioAuthenticated).usuario)),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.green[600],
            );
          } else if (state is TimerInitial) {
            return FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
                BlocProvider.of<MesocicloBloc>(context).add(SesionStarted());
                BlocProvider.of<TimerBloc>(context).add(TimerStarted(seconds: state.seconds));
              },
              child: Icon(Icons.play_arrow),
              backgroundColor: Colors.green[600],
            );
          } else {
            return Container();
          }
        });
      }),
    );
  }
}
