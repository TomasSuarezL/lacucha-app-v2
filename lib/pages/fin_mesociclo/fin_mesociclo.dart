import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacucha_app_v2/bloc/mesociclo/bloc/mesociclo_bloc.dart';
import 'package:lacucha_app_v2/models/estado_mesociclo.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/models/usuario.dart';
import 'package:lacucha_app_v2/pages/components/button_success.dart';
import 'package:lacucha_app_v2/services/train_service.dart';

class FinMesociclo extends StatefulWidget {
  FinMesociclo({Key key, this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  _FinMesocicloState createState() => _FinMesocicloState();
}

class _FinMesocicloState extends State<FinMesociclo> {
  bool _aumentoMotivacion;
  bool _masCercaObjetivos;
  int _sentimiento;
  int _durmiendo;
  int _alimentando;

  Mesociclo _mesociclo;

  bool _loading;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _aumentoMotivacion = false;
    _masCercaObjetivos = false;
    _sentimiento = 3;
    _durmiendo = 3;
    _alimentando = 3;
    _mesociclo = BlocProvider.of<MesocicloBloc>(context).state.mesociclo;
    _loading = false;
  }

  Widget _objetivosSelect() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 16.0),
          Text("Sentis que estás mas cerca de tus objetivos?", style: Theme.of(context).textTheme.subtitle1),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: 64,
                  decoration: BoxDecoration(
                    color: _masCercaObjetivos == false ? Colors.lightBlue[50] : Colors.white70,
                  ),
                  child: Text(
                    "No",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  setState(() => _masCercaObjetivos = false);
                },
              ),
              SizedBox(width: 16.0),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: 64,
                  decoration: BoxDecoration(
                    color: _masCercaObjetivos == true ? Colors.lightBlue[50] : Colors.white70,
                  ),
                  child: Text(
                    "Si",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  setState(() => _masCercaObjetivos = true);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _motivacionSelect() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 16.0),
          Text("Sentis que aumentó tu motivación?", style: Theme.of(context).textTheme.subtitle1),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: 64,
                  decoration: BoxDecoration(
                    color: _aumentoMotivacion == false ? Colors.lightBlue[50] : Colors.white70,
                  ),
                  child: Text(
                    "No",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  setState(() => _aumentoMotivacion = false);
                },
              ),
              SizedBox(width: 16.0),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: 64,
                  decoration: BoxDecoration(
                    color: _aumentoMotivacion == true ? Colors.lightBlue[50] : Colors.white70,
                  ),
                  child: Text(
                    "Si",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  setState(() => _aumentoMotivacion = true);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _sentimientoSelect() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 16.0),
          Text("Cómo te sentiste durante el mesociclo?", style: Theme.of(context).textTheme.subtitle1),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [1, 2, 3, 4, 5]
                .map((e) => InputRatingCell(
                    number: e, field: _sentimiento, onClick: (number) => setState(() => _sentimiento = number)))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _durmiendoSelect() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 16.0),
          Text("Cómo dormiste durante el mesociclo?", style: Theme.of(context).textTheme.subtitle1),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [1, 2, 3, 4, 5]
                .map((e) => InputRatingCell(
                    number: e, field: _durmiendo, onClick: (number) => setState(() => _durmiendo = number)))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _alimentandoSelect() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 16.0),
          Text("Cómo te alimentaste durante el mesociclo?", style: Theme.of(context).textTheme.subtitle1),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [1, 2, 3, 4, 5]
                .map((e) => InputRatingCell(
                    number: e, field: _alimentando, onClick: (number) => setState(() => _alimentando = number)))
                .toList(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Mesociclo Finalizado'),
      ),
      body: Container(
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  ListView(
                    shrinkWrap: false,
                    children: [
                      _objetivosSelect(),
                      _motivacionSelect(),
                      _sentimientoSelect(),
                      _durmiendoSelect(),
                      _alimentandoSelect()
                    ],
                  ),
                  Positioned(
                    bottom: 16.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonSuccess(
                            text: "Aceptar",
                            onPressed: () async {
                              _mesociclo.aumentoMotivacion = _aumentoMotivacion;
                              _mesociclo.masCercaObjetivos = _masCercaObjetivos;
                              _mesociclo.sentimiento = _sentimiento;
                              _mesociclo.alimentando = _alimentando;
                              _mesociclo.durmiendo = _durmiendo;
                              _mesociclo.estado = EstadoMesociclo.terminado;
                              setState(() => _loading = true);
                              try {
                                await TrainService.putMesociclo(
                                    _mesociclo, await FirebaseAuth.instance.currentUser.getIdToken());
                                BlocProvider.of<MesocicloBloc>(context)
                                    .add(MesocicloFetched(idUsuario: widget.usuario.idUsuario));
                                Navigator.pop(context);
                              } catch (e) {
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red[200],
                                    content: Text("Error al guardar el mesociclo."),
                                  ),
                                );
                              } finally {
                                setState(() => _loading = false);
                              }
                            }),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class InputRatingCell extends StatelessWidget {
  final int field;
  final int number;
  final Function onClick;

  InputRatingCell({Key key, this.onClick, this.field, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(16),
        width: 64,
        decoration: BoxDecoration(
          color: field == number ? Colors.lightBlue[50] : Colors.white70,
        ),
        child: Text(
          number.toString(),
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        onClick(number);
      },
    );
  }
}
