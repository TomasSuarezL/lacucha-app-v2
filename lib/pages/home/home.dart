import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacucha_app_v2/bloc/mesociclo/bloc.dart';
import 'package:lacucha_app_v2/bloc/usuario/bloc/usuario_bloc.dart';
import 'package:lacucha_app_v2/constants.dart';

import 'components/home_perfil_card.dart';
import 'components/home_mesociclo_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.changeIndex}) : super(key: key);

  final String title;
  final Function changeIndex;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UsuarioBloc _usuarioBloc;

  @override
  void initState() {
    super.initState();
    _usuarioBloc = BlocProvider.of<UsuarioBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Cerrar Sesión',
              style: Theme.of(context).textTheme.button.apply(color: Colors.white70),
            ),
            onPressed: () {
              _usuarioBloc.add(UsuarioLogOut());
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [secondaryColor, secondaryColorLight]),
              image: DecorationImage(
                image: AssetImage("assets/la_cucha_background.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(secondaryColor.withOpacity(0.6), BlendMode.dstOut),
              ),
            ),
          ),
          _HomeContent(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.changeIndex(1),
        tooltip: 'Start',
        child: Icon(Icons.play_arrow),
        backgroundColor: Colors.green[600],
      ),
    );
  }

  @override
  void dispose() {
    _usuarioBloc.close();
    super.dispose();
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsuarioBloc, UsuarioState>(builder: (usuarioContext, usuarioState) {
      if (usuarioState is UsuarioInitial) {
        return Center(child: CircularProgressIndicator());
      } else if (usuarioState is UsuarioAuthenticated) {
        MesocicloBloc _mesocicloBloc = BlocProvider.of<MesocicloBloc>(usuarioContext);
        if (_mesocicloBloc.state is MesocicloInitial)
          _mesocicloBloc.add(MesocicloFetched(idUsuario: usuarioState.usuario.idUsuario));
        return ListView(
          children: <Widget>[PerfilCard(usuario: usuarioState.usuario), HomeMesocicloCard()],
        );
      } else {
        return Center(child: Text("Error al recuperar el usuario."));
      }
    });
  }
}
