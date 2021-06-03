import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacucha_app_v2/bloc/mesociclo/bloc/mesociclo_bloc.dart';
import 'package:lacucha_app_v2/models/ejercicio_x_bloque.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/models/patrones_cantidades.dart';
import 'package:lacucha_app_v2/pages/components/button_success.dart';
import 'package:lacucha_app_v2/pages/nuevo_mesociclo/components/nueva_sesion_card.dart';

class NuevoResumen extends StatefulWidget {
  NuevoResumen({Key key, this.mesociclo, this.patrones}) : super(key: key);

  Mesociclo mesociclo;
  PatronesCantidades patrones;

  @override
  _NuevoResumenState createState() => _NuevoResumenState();
}

class _NuevoResumenState extends State<NuevoResumen> {
  Mesociclo _nuevoMesociclo;

  @override
  void initState() {
    super.initState();

    _calcSesiones();
  }

  Future _calcSesiones() async {
    await widget.mesociclo.calcSesiones(widget.patrones);
    setState(() {
      _nuevoMesociclo = widget.mesociclo;
    });
  }

  void updateEjercicio(int numSesion, int numBloque, int numEjercicio, EjercicioXBloque ejercicio) {
    widget.mesociclo.sesiones[numSesion].bloques[numBloque].ejercicios[numEjercicio] = ejercicio;
    setState(() {
      _nuevoMesociclo = widget.mesociclo;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_nuevoMesociclo == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('Nuevo Mesociclo'),
          ),
          body: Center(
            child: Container(
              color: Colors.grey[100],
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Resumen Mesociclo",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Entrenamiento Semanal",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: _nuevoMesociclo.sesiones.length,
                          itemBuilder: (BuildContext context, int index) {
                            return NuevaSesionCard(
                                sesion: _nuevoMesociclo.sesiones[index],
                                index: index + 1,
                                updateEjercicio: updateEjercicio);
                          })),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonSuccess(
                          text: "Aceptar",
                          onPressed: () {
                            BlocProvider.of<MesocicloBloc>(context).add(MesocicloCreated(mesociclo: _nuevoMesociclo));
                            Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
    }
  }
}
