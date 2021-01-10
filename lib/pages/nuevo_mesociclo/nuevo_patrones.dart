import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/models/patrones_cantidades.dart';
import 'package:lacucha_app_v2/pages/components/button_success.dart';
import 'package:lacucha_app_v2/pages/nuevo_mesociclo/nuevo_resumen.dart';

class NuevoPatrones extends StatefulWidget {
  NuevoPatrones({Key key, this.mesociclo}) : super(key: key);

  Mesociclo mesociclo;

  @override
  _NuevoPatronesState createState() => _NuevoPatronesState();
}

class _NuevoPatronesState extends State<NuevoPatrones> {
  int _traccion;
  int _empuje;
  int _rodilla;
  int _cadera;
  int _core;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _traccion = widget.mesociclo.sesionesPorSemana * 4;
    _empuje = widget.mesociclo.sesionesPorSemana * 4;
    _cadera = widget.mesociclo.sesionesPorSemana * 3;
    _rodilla = widget.mesociclo.sesionesPorSemana * 3;
    _core = widget.mesociclo.sesionesPorSemana * 4;
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Patrones Por Semana",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Traccion",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 32),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(filled: true),
                              initialValue: _traccion.toString(),
                              onChanged: (value) => setState(() => _traccion = int.tryParse(value)),
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 16),
                            child: Text("veces."),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Empuje",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 32),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(filled: true),
                              initialValue: _empuje.toString(),
                              onChanged: (value) => setState(() => _empuje = int.tryParse(value)),
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 16),
                            child: Text("veces."),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Rodilla",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 32),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(filled: true),
                              initialValue: _rodilla.toString(),
                              onChanged: (value) => setState(() => _rodilla = int.tryParse(value)),
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 16),
                            child: Text("veces."),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Cadera",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 32),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(filled: true),
                              initialValue: _cadera.toString(),
                              onChanged: (value) => setState(() => _cadera = int.tryParse(value)),
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 16),
                            child: Text("veces."),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Core",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 32),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(filled: true),
                              initialValue: _core.toString(),
                              onChanged: (value) => setState(() => _core = int.tryParse(value)),
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 16),
                            child: Text("veces."),
                          ),
                        ],
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
                        if (_traccion == null ||
                            _cadera == null ||
                            _core == null ||
                            _rodilla == null ||
                            _empuje == null) {
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red[300],
                              content: Text("Debe completar las cantidades por patron"),
                            ),
                          );
                        } else {
                          PatronesCantidades patronesCantidades =
                              PatronesCantidades(_traccion, _empuje, _rodilla, _cadera, _core);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NuevoResumen(
                                  mesociclo: widget.mesociclo,
                                  patrones: patronesCantidades,
                                ),
                              ));
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
