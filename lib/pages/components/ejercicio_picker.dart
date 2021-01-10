import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/models/ejercicio.dart';

class EjercicioPicker extends StatelessWidget {
  EjercicioPicker({Key key, this.ejercicios, this.setEjercicio}) : super(key: key);

  List<Ejercicio> ejercicios;
  Function setEjercicio;

  Widget _ejercicioOption(BuildContext context, Ejercicio ejercicio) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
        ),
        child: Text(ejercicio.nombre),
      ),
      onTap: () {
        setEjercicio(ejercicio);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccionar Ejercicio"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: ejercicios.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _ejercicioOption(context, ejercicios[index]);
                  }),
            )
          ],
        ),
      ),
    );
    ;
  }
}
