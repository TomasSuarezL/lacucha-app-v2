import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/bloque.dart';
import 'package:lacucha_app_v2/models/ejercicio.dart';
import 'package:lacucha_app_v2/models/ejercicio_x_bloque.dart';
import 'package:lacucha_app_v2/models/sesion.dart';

class TrainService {
  static final EjercicioXBloque _exampleEjercicio1 = EjercicioXBloque(
    idEjerciciosxbloque: 1,
    ejercicio: Ejercicio(idEjercicio: 1, nombre: "Flexiones", patron: "Tren Superior"),
    repeticiones: 10,
    carga: 10.0,
  );
  static final EjercicioXBloque _exampleEjercicio2 = EjercicioXBloque(
    idEjerciciosxbloque: 2,
    ejercicio: Ejercicio(idEjercicio: 2, nombre: "Sentadillas", patron: "Tren Inferior"),
    repeticiones: 8,
    carga: 20.0,
  );
  static final EjercicioXBloque _exampleEjercicio3 = EjercicioXBloque(
    idEjerciciosxbloque: 3,
    ejercicio: Ejercicio(idEjercicio: 3, nombre: "Hollow Press", patron: "Zona Media"),
    repeticiones: 15,
    carga: 0.0,
  );

  static final Bloque _exampleBloque1 = Bloque(
    idBloque: 1,
    numBloque: 1,
    series: 4,
    ejercicios: [_exampleEjercicio1, _exampleEjercicio2, _exampleEjercicio3],
  );

  static final Bloque _exampleBloque2 = Bloque(
    idBloque: 2,
    numBloque: 2,
    series: 4,
    ejercicios: [_exampleEjercicio1, _exampleEjercicio2, _exampleEjercicio3],
  );

  static final Sesion _exampleSession = Sesion(
    idSesion: 1,
    fechaEmpezado: DateTime.now(),
    fechaFinalizado: null,
    bloques: [_exampleBloque1, _exampleBloque2],
  );

  static Sesion getDummySesion() {
    return _exampleSession;
  }

  static Future<bool> putSesion(Sesion sesion) async {
    var _sesionJson = sesion.toJson();
    String _sesionId = sesion.idSesion.toString();
    final response =
        await http.put('$apiBaseUrl/sesiones/$_sesionId', headers: {"content-type": "application/json"}, body: jsonEncode(_sesionJson));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
