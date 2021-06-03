import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/models/organizacion.dart';
import 'package:lacucha_app_v2/pages/components/button_success.dart';
import 'package:lacucha_app_v2/pages/nuevo_mesociclo/nuevo_ejercicios_principales.dart';

class NuevoOrganizacion extends StatefulWidget {
  NuevoOrganizacion({Key key, this.mesociclo}) : super(key: key);

  Mesociclo mesociclo;

  @override
  _NuevoOrganizacionState createState() => _NuevoOrganizacionState();
}

class _NuevoOrganizacionState extends State<NuevoOrganizacion> {
  Organizacion _organizacion;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _selectOrganizacion(Organizacion organizacion) {
    setState(() {
      _organizacion = organizacion;
    });
  }

  Row _nextButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ButtonSuccess(
          text: "Siguiente",
          onPressed: () {
            if (_organizacion == null) {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red[300],
                  content: Text("Debe seleccionar una organización"),
                ),
              );
            } else {
              widget.mesociclo.organizacion = _organizacion;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NuevoEjerciciosPrincipales(
                            mesociclo: widget.mesociclo,
                          )));
            }
          },
        ),
      ],
    );
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
                  "Organizacion",
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
                          color: _organizacion == Organizacion.full_body ? Colors.lightBlue[50] : Colors.white70,
                          child: Text(
                            "Full Body",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        onTap: () {
                          _selectOrganizacion(Organizacion.full_body);
                        },
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
                            color: _organizacion == Organizacion.tren_superior_inferior
                                ? Colors.lightBlue[50]
                                : Colors.white70,
                          ),
                          child: Text(
                            "Tren Superior / Tren Inferior",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        onTap: () {
                          _selectOrganizacion(Organizacion.tren_superior_inferior);
                        },
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
                            color: _organizacion == Organizacion.combinado ? Colors.lightBlue[50] : Colors.white70,
                          ),
                          child: Text(
                            "Combinado",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        onTap: () {
                          _selectOrganizacion(Organizacion.combinado);
                        },
                      ),
                    ],
                  ),
                ),
                _nextButton(context)
              ],
            ),
          ),
        ));
  }
}
