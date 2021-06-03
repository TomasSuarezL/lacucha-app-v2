import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lacucha_app_v2/models/bloque.dart';
import 'package:lacucha_app_v2/models/ejercicio_x_bloque.dart';
import 'package:lacucha_app_v2/models/estado_mesociclo.dart';
import 'package:lacucha_app_v2/models/patrones_cantidades.dart';
import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:lacucha_app_v2/models/usuario.dart';
import 'package:lacucha_app_v2/services/train_service.dart';

import 'ejercicio.dart';
import 'nivel.dart';
import 'objetivo.dart';
import 'organizacion.dart';

part 'mesociclo.g.dart';

@JsonSerializable()
class Mesociclo {
  int idMesociclo;
  Usuario usuario;
  EstadoMesociclo estado;
  Nivel nivel;
  Objetivo objetivo;
  Organizacion organizacion;
  Ejercicio principalTrenSuperior;
  Ejercicio principalTrenInferior;
  int semanasPorMesociclo;
  int sesionesPorSemana;
  List<Sesion> sesiones;
  bool aumentoMotivacion;
  bool masCercaObjetivos;
  int sentimiento;
  int durmiendo;
  int alimentando;
  DateTime creadoEn;
  DateTime actualizadoEn;

  Mesociclo(
      {this.idMesociclo,
      this.usuario,
      this.estado,
      this.nivel,
      this.objetivo,
      this.organizacion,
      this.principalTrenInferior,
      this.principalTrenSuperior,
      this.semanasPorMesociclo,
      this.sesionesPorSemana,
      this.sesiones});

  Sesion get proximaSesion => this.sesiones.firstWhere(
      (s) => s.fechaFinalizado == null && s.fechaEmpezado.difference(DateTime.now()).inDays != 0,
      orElse: () => null);

  calcSesiones(PatronesCantidades patrones) async {
    this.sesiones = [];

    // Aca pasa la magia. Calculo en base a los datos ingresados del nuevo mesociclo, como deberian ser las proximas sesiones
    String _token = await FirebaseAuth.instance.currentUser.getIdToken();

    List<Ejercicio> _ejerciciosTrenSuperior = await TrainService.getEjerciciosPorPatron("Tren Superior", _token);
    List<Ejercicio> _ejerciciosTrenInferior = await TrainService.getEjerciciosPorPatron("Tren Inferior", _token);
    List<Ejercicio> _ejerciciosCore = await TrainService.getEjerciciosPorPatron("Core", _token);

    List<int> _indexesTrenSuperior = List.generate(_ejerciciosTrenSuperior.length, (index) => index)..shuffle();
    List<int> _indexesTrenInferior = List.generate(_ejerciciosTrenInferior.length, (index) => index)..shuffle();
    List<int> _indexesCore = List.generate(_ejerciciosCore.length, (index) => index)..shuffle();

    for (var i = 0; i < this.semanasPorMesociclo; i++) {
      for (var j = 0; j < this.sesionesPorSemana; j++) {
        // Carga y repeticiones? como se genera? input?
        EjercicioXBloque ex1 =
            EjercicioXBloque(carga: 10, repeticiones: 10, ejercicio: _ejerciciosTrenSuperior[_indexesTrenSuperior[0]]);
        EjercicioXBloque ex2 =
            EjercicioXBloque(carga: 11, repeticiones: 11, ejercicio: _ejerciciosTrenInferior[_indexesTrenInferior[0]]);
        EjercicioXBloque ex3 =
            EjercicioXBloque(carga: 12, repeticiones: 12, ejercicio: _ejerciciosCore[_indexesCore[0]]);

        EjercicioXBloque ex4 =
            EjercicioXBloque(carga: 13, repeticiones: 13, ejercicio: _ejerciciosTrenSuperior[_indexesTrenSuperior[1]]);
        EjercicioXBloque ex5 =
            EjercicioXBloque(carga: 14, repeticiones: 14, ejercicio: _ejerciciosTrenInferior[_indexesTrenInferior[1]]);
        EjercicioXBloque ex6 =
            EjercicioXBloque(carga: 15, repeticiones: 15, ejercicio: _ejerciciosCore[_indexesCore[1]]);

        EjercicioXBloque ex7 =
            EjercicioXBloque(carga: 16, repeticiones: 16, ejercicio: _ejerciciosTrenSuperior[_indexesTrenSuperior[2]]);
        EjercicioXBloque ex8 =
            EjercicioXBloque(carga: 17, repeticiones: 17, ejercicio: _ejerciciosTrenInferior[_indexesTrenInferior[2]]);
        EjercicioXBloque ex9 =
            EjercicioXBloque(carga: 18, repeticiones: 18, ejercicio: _ejerciciosCore[_indexesCore[2]]);

        Bloque _nuevoBloque1 = Bloque(series: 4, numBloque: 1, ejercicios: [ex1, ex2, ex3]);
        Bloque _nuevoBloque2 = Bloque(series: 4, numBloque: 2, ejercicios: [ex4, ex5, ex6]);
        Bloque _nuevoBloque3 = Bloque(series: 4, numBloque: 3, ejercicios: [ex7, ex8, ex9]);

        Sesion _nuevaSesion = Sesion(
            fechaEmpezado: DateTime.now().add(Duration(days: (7 * i + (((7 / this.sesionesPorSemana) * j).floor())))),
            bloques: [_nuevoBloque1, _nuevoBloque2, _nuevoBloque3]);

        this.sesiones.add(_nuevaSesion);
      }
    }
  }

  factory Mesociclo.fromJson(Map<String, dynamic> json) => _$MesocicloFromJson(json);

  Map<String, dynamic> toJson() => _$MesocicloToJson(this);

  Map<String, dynamic> toPostJson() => <String, dynamic>{
        'usuario': this.usuario.toIdJson(),
        'nivel': this.nivel.toIdJson(),
        'objetivo': this.objetivo.toIdJson(),
        'organizacion': this.organizacion.toIdJson(),
        'principalTrenSuperior': this.principalTrenSuperior.toIdJson(),
        'principalTrenInferior': this.principalTrenInferior.toIdJson(),
        'semanasPorMesociclo': this.semanasPorMesociclo,
        'sesionesPorSemana': this.sesionesPorSemana,
        'sesiones': this.sesiones.map((e) => e.toPostJson()).toList()
      };

  Map<String, dynamic> toPutJson() => <String, dynamic>{
        'idMesociclo': this.idMesociclo,
        'estado': this.estado.toIdJson(),
        'usuario': this.usuario.toIdJson(),
        'nivel': this.nivel.toIdJson(),
        'objetivo': this.objetivo.toIdJson(),
        'organizacion': this.organizacion.toIdJson(),
        'principalTrenSuperior': this.principalTrenSuperior.toIdJson(),
        'principalTrenInferior': this.principalTrenInferior.toIdJson(),
        'semanasPorMesociclo': this.semanasPorMesociclo,
        'sesionesPorSemana': this.sesionesPorSemana,
        'sesiones': this.sesiones.map((e) => e.toPostJson()).toList()
      };
}
