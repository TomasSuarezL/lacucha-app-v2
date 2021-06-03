import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/models/ejercicio.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/pages/components/button_success.dart';
import 'package:lacucha_app_v2/pages/components/ejercicio_picker.dart';
import 'package:lacucha_app_v2/pages/nuevo_mesociclo/nuevo_patrones.dart';
import 'package:lacucha_app_v2/services/train_service.dart';

class NuevoEjerciciosPrincipales extends StatefulWidget {
  NuevoEjerciciosPrincipales({Key key, this.mesociclo}) : super(key: key);

  final Mesociclo mesociclo;

  @override
  _NuevoEjerciciosPrincipalesState createState() => _NuevoEjerciciosPrincipalesState();
}

class _NuevoEjerciciosPrincipalesState extends State<NuevoEjerciciosPrincipales> {
  Ejercicio _ejercicioTrenSuperior;
  Ejercicio _ejercicioTrenInferior;

  bool _loading;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _setEjercicioTrenSuperior(Ejercicio ejercicioTrenSuperior) {
    setState(() {
      _ejercicioTrenSuperior = ejercicioTrenSuperior;
    });
  }

  void _setEjercicioTrenInferior(Ejercicio ejercicioTrenInferior) {
    setState(() {
      _ejercicioTrenInferior = ejercicioTrenInferior;
    });
  }

  @override
  void initState() {
    _loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Nuevo Mesociclo'),
        ),
        body: Center(
          child: _loading
              ? CircularProgressIndicator()
              : Container(
                  color: Colors.grey[100],
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Ejercicios Principales",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 64.0,
                            ),
                            Text(
                              "Ejercicio Tren Superior",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            InkWell(
                              child: Container(
                                child: Text(
                                  _ejercicioTrenSuperior == null
                                      ? "Seleccionar Ejercicio Tren Superior"
                                      : "${_ejercicioTrenSuperior.nombre}",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                padding: EdgeInsets.all(16),
                                color: Colors.white70,
                              ),
                              onTap: () async {
                                setState(() => _loading = true);
                                List<Ejercicio> _ejercicios = await TrainService.getEjerciciosPorPatron(
                                    "Tren Superior", await FirebaseAuth.instance.currentUser.getIdToken());
                                setState(() => _loading = false);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EjercicioPicker(
                                      ejercicios: _ejercicios,
                                      setEjercicio: _setEjercicioTrenSuperior,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 64.0,
                            ),
                            Text(
                              "Ejercicio Tren Inferior",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            InkWell(
                              child: Container(
                                child: Text(
                                  _ejercicioTrenInferior == null
                                      ? "Seleccionar Ejercicio Tren Inferior"
                                      : "${_ejercicioTrenInferior.nombre}",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                padding: EdgeInsets.all(16),
                                color: Colors.white70,
                              ),
                              onTap: () async {
                                setState(() => _loading = true);
                                List<Ejercicio> _ejercicios = await TrainService.getEjerciciosPorPatron(
                                    "Tren Inferior", await FirebaseAuth.instance.currentUser.getIdToken());
                                setState(() => _loading = false);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EjercicioPicker(
                                      ejercicios: _ejercicios,
                                      setEjercicio: _setEjercicioTrenInferior,
                                    ),
                                  ),
                                );
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
                              widget.mesociclo.principalTrenSuperior = _ejercicioTrenSuperior;
                              widget.mesociclo.principalTrenInferior = _ejercicioTrenInferior;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NuevoPatrones(mesociclo: widget.mesociclo),
                                  ));
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
