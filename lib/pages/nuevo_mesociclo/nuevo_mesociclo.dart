import 'package:flutter/material.dart';
import 'package:lacucha_app_v2/models/estado_mesociclo.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/models/usuario.dart';
import 'package:lacucha_app_v2/pages/nuevo_mesociclo/nuevo_objetivo.dart';

class NuevoMesociclo extends StatefulWidget {
  NuevoMesociclo({Key key, this.usuario}) : super(key: key);

  Usuario usuario;

  @override
  _NuevoMesocicloState createState() => _NuevoMesocicloState();
}

class _NuevoMesocicloState extends State<NuevoMesociclo> {
  Mesociclo nuevoMesociclo;

  @override
  void initState() {
    super.initState();

    nuevoMesociclo = Mesociclo(usuario: widget.usuario, nivel: widget.usuario.nivel);
  }

  @override
  Widget build(BuildContext context) {
    return NuevoObjetivo(mesociclo: nuevoMesociclo);
  }
}
