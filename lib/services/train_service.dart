import 'dart:convert';

import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/bloque.dart';
import 'package:lacucha_app_v2/models/ejercicio.dart';
import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:http/http.dart' as http;

class TrainService {
  static final Ejercicio _exampleEjercicio1 = Ejercicio(
    idEjercicio: 1,
    ejercicio: "Flexiones",
    patron: "Tren Superior",
    repeticiones: 10,
    carga: 10.0,
  );
  static final Ejercicio _exampleEjercicio2 = Ejercicio(
    idEjercicio: 2,
    ejercicio: "Sentadillas",
    patron: "Tren Inferior",
    repeticiones: 8,
    carga: 20.0,
  );
  static final Ejercicio _exampleEjercicio3 = Ejercicio(
    idEjercicio: 3,
    ejercicio: "Hollow Press",
    patron: "Zona Media",
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

  static Future<Sesion> getSesion() async {
    final response = await http.get('$apiBaseUrl/sesiones/todaySession');
    if (response.statusCode == 200) {
      return Sesion.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener sesion del dia.');
    }
  }
}
