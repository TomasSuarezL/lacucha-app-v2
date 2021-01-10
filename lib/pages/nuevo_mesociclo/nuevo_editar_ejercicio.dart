import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/models/ejercicio.dart';
import 'package:lacucha_app_v2/models/ejercicio_x_bloque.dart';
import 'package:lacucha_app_v2/pages/components/button_success.dart';
import 'package:lacucha_app_v2/pages/components/ejercicio_picker.dart';
import 'package:lacucha_app_v2/services/train_service.dart';

class EjercicioEditor extends StatefulWidget {
  EjercicioEditor({Key key, this.ejercicio, this.setEjercicio}) : super(key: key);

  EjercicioXBloque ejercicio;
  Function setEjercicio;

  @override
  _EjercicioEditorState createState() => _EjercicioEditorState();
}

class _EjercicioEditorState extends State<EjercicioEditor> {
  String _patron;
  Ejercicio _ejercicio;
  double _carga;
  int _reps;
  List<String> patrones = <String>['Tren Superior', 'Tren Inferior', 'Core'];

  void _setEjercicio(Ejercicio ejercicio) {
    setState(() {
      _ejercicio = ejercicio;
    });
  }

  @override
  initState() {
    super.initState();

    switch (widget.ejercicio.ejercicio.patron) {
      case "Empuje":
      case "Traccion":
        _patron = "Tren Superior";
        break;
      case "Rodilla":
      case "Cadera":
        _patron = "Tren Inferior";
        break;
      case "Core":
        _patron = "Core";
        break;
      default:
    }

    _ejercicio = widget.ejercicio.ejercicio;
    _carga = widget.ejercicio.carga;
    _reps = widget.ejercicio.repeticiones;
  }

  Widget _guardar(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ButtonSuccess(
        text: "Guardar",
        onPressed: () {
          widget.setEjercicio(EjercicioXBloque(carga: _carga, repeticiones: _reps, ejercicio: _ejercicio));
          Navigator.pop(context);
        },
      ),
    ]);
  }

  Widget _patronInput(BuildContext context) {
    return Row(
      children: [
        Text("Patron"),
        Container(
          margin: EdgeInsets.only(left: 16.0),
          child: DropdownButton<String>(
            value: _patron,
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                _ejercicio = null;
                _patron = newValue;
              });
            },
            items: patrones.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _ejercicioInput(BuildContext context) {
    return Row(
      children: [
        Text("Ejercicio"),
        InkWell(
          child: Container(
            margin: EdgeInsets.only(left: 16.0),
            child: Text(
              _ejercicio == null ? "Seleccionar Ejercicio" : "${_ejercicio.nombre}",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            padding: EdgeInsets.all(16),
            color: Colors.white70,
          ),
          onTap: () async {
            List<Ejercicio> _ejercicios = await TrainService.getEjerciciosPorPatron(_patron);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EjercicioPicker(
                  ejercicios: _ejercicios,
                  setEjercicio: _setEjercicio,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _repsInput(BuildContext context) {
    return Row(
      children: [
        Text("Repeticiones"),
        Container(
          width: 100,
          margin: EdgeInsets.only(left: 16.0, right: 8.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(filled: true),
            initialValue: "${_reps.toString()}",
            onChanged: (value) => setState(() {
              _reps = int.tryParse(value);
            }),
          ),
        ),
        Text("Reps."),
      ],
    );
  }

  Widget _cargaInput(BuildContext context) {
    return Row(
      children: [
        Text("Carga"),
        Container(
          width: 100,
          margin: EdgeInsets.only(left: 16.0, right: 8.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(filled: true),
            initialValue: "${_carga.toString()}",
            onChanged: (value) => setState(() {
              _carga = double.tryParse(value);
            }),
          ),
        ),
        Text("Kgs."),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccionar Ejercicio"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Editar Ejercicio",
                style: Theme.of(context).textTheme.headline6,
              ),
              Flexible(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _patronInput(context),
                      _ejercicioInput(context),
                      _repsInput(context),
                      _cargaInput(context),
                    ],
                  ),
                ),
              ),
              _guardar(context)
            ],
          ),
        ),
      ),
    );
  }
}
