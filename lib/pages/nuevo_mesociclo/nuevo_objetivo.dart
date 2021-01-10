import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/models/objetivo.dart';
import 'package:lacucha_app_v2/pages/components/button_success.dart';
import 'package:lacucha_app_v2/pages/nuevo_mesociclo/nuevo_agenda.dart';

class NuevoObjetivo extends StatefulWidget {
  NuevoObjetivo({Key key, this.mesociclo}) : super(key: key);

  Mesociclo mesociclo;

  @override
  _NuevoObjetivoState createState() => _NuevoObjetivoState();
}

class _NuevoObjetivoState extends State<NuevoObjetivo> {
  Objetivo _objetivo;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _selectObjetivo(Objetivo objetivo) {
    setState(() {
      _objetivo = objetivo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Nuevo Mesociclo'),
      ),
      body: Center(
        child: Container(
          color: Colors.grey[100],
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Objetivo",
                style: Theme.of(context).textTheme.headline4,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(32),
                        color: _objetivo == Objetivo.acondicionamiento_general ? Colors.lightBlue[50] : Colors.white70,
                        child: Text(
                          "Acondicionamiento General",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      onTap: () {
                        _selectObjetivo(Objetivo.acondicionamiento_general);
                      },
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
                          color: _objetivo == Objetivo.hipertrofia ? Colors.lightBlue[50] : Colors.white70,
                        ),
                        child: Text(
                          "Hipertrofia",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      onTap: () {
                        _selectObjetivo(Objetivo.hipertrofia);
                      },
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
                          color: _objetivo == Objetivo.fuerza ? Colors.lightBlue[50] : Colors.white70,
                        ),
                        child: Text(
                          "Fuerza",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      onTap: () {
                        _selectObjetivo(Objetivo.fuerza);
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonSuccess(
                    text: "Siguiente",
                    onPressed: () {
                      if (_objetivo == null) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[300],
                            content: Text("Debe seleccionar al menos un objetivo"),
                          ),
                        );
                      } else {
                        widget.mesociclo.objetivo = _objetivo;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NuevoAgenda(
                              mesociclo: widget.mesociclo,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
