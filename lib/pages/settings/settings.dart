import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lacucha_app_v2/bloc/mesociclo/bloc/mesociclo_bloc.dart';
import 'package:lacucha_app_v2/bloc/usuario/bloc/usuario_bloc.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/services/train_service.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  UsuarioBloc _usuarioBloc;

  @override
  void initState() {
    super.initState();
    _usuarioBloc = BlocProvider.of<UsuarioBloc>(context);
  }

  Widget _emptyCacheSetting(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
        ),
        child: Text("Borrar Cache"),
      ),
      onTap: () async {
        try {
          await DefaultCacheManager().emptyCache();
        } catch (e) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(backgroundColor: Colors.red[200], content: Text("Error al borrar la cache")));
        }

        _scaffoldKey.currentState
            .showSnackBar(SnackBar(backgroundColor: Colors.lightGreen[200], content: Text("Cache borrada")));
      },
    );
  }

  Widget _deleteMesocicloSetting(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
        ),
        child: Text("Eliminar Mesociclo"),
      ),
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Eliminar Mesociclo?'),
            content: new Text('Se perderán los datos del mesociclo actual.'),
            actions: <Widget>[
              new FlatButton(child: Text("Cancelar"), onPressed: () => Navigator.of(context).pop()),
              new RaisedButton(
                onPressed: () async {
                  Mesociclo _mesocicloActual = BlocProvider.of<MesocicloBloc>(context).state.mesociclo;
                  if (_mesocicloActual != null) {
                    try {
                      await TrainService.deleteMesociclo(
                          _mesocicloActual, await FirebaseAuth.instance.currentUser.getIdToken());
                      BlocProvider.of<MesocicloBloc>(context).add(
                          MesocicloFetched(idUsuario: (_usuarioBloc.state as UsuarioAuthenticated).usuario.idUsuario));
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.lightBlue[200],
                          content: Text("Mesociclo eliminado."),
                        ),
                      );
                    } catch (e) {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red[200],
                          content: Text("Error al actualizar mesociclo."),
                        ),
                      );
                    }
                  } else {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[200],
                        content: Text("No hay mesociclo activo."),
                      ),
                    );
                  }
                  Navigator.of(context).pop();
                },
                color: Colors.lightGreen[200],
                child: Text("Si"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: [_emptyCacheSetting(context), _deleteMesocicloSetting(context)],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
