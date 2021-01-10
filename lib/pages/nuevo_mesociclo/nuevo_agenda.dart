import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/pages/components/button_success.dart';
import 'package:lacucha_app_v2/pages/nuevo_mesociclo/nuevo_organizacion.dart';

class NuevoAgenda extends StatefulWidget {
  NuevoAgenda({Key key, this.mesociclo}) : super(key: key);

  Mesociclo mesociclo;

  @override
  _NuevoAgendaState createState() => _NuevoAgendaState();
}

class _NuevoAgendaState extends State<NuevoAgenda> {
  int _semanasPorMesociclo;
  int _sesionesPorSemana;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _semanasPorMesociclo = 4;
    _sesionesPorSemana = 3;
  }

  void _setSesionesPorSemana(int sesionesPorSemana) {
    setState(() {
      _sesionesPorSemana = sesionesPorSemana;
    });
  }

  void _setSemanasPorMesociclo(int semanasPorMesociclo) {
    setState(() {
      _semanasPorMesociclo = semanasPorMesociclo;
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
                "Agenda",
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
                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: 4.toString(),
                      decoration: InputDecoration(filled: true, labelText: "Semanas Por Mesociclo"),
                      onChanged: (value) => _setSemanasPorMesociclo(int.tryParse(value)),
                    ),
                    SizedBox(
                      height: 64.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: 3.toString(),
                      decoration: InputDecoration(filled: true, labelText: "Sesiones Por Semana"),
                      onChanged: (value) => _setSesionesPorSemana(int.tryParse(value)),
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
                      if (_semanasPorMesociclo == null || _sesionesPorSemana == null) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[300],
                            content: Text("Debe completar todos los campos"),
                          ),
                        );
                      } else {
                        widget.mesociclo.sesionesPorSemana = _sesionesPorSemana;
                        widget.mesociclo.semanasPorMesociclo = _semanasPorMesociclo;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NuevoOrganizacion(
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
