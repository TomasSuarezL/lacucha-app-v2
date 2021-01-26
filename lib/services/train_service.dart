import 'dart:convert';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/bloque.dart';
import 'package:lacucha_app_v2/models/ejercicio.dart';
import 'package:lacucha_app_v2/models/ejercicio_x_bloque.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
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

  static Future<bool> putSesion(Sesion sesion, String token) async {
    var _sesionJson = sesion.toJson();
    String _sesionId = sesion.idSesion.toString();
    final response = await http.put('$apiBaseUrl/sesiones/$_sesionId',
        headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"},
        body: jsonEncode(_sesionJson));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Ejercicio>> getEjerciciosPorPatron(String patron, String token) async {
    String _subPatrones;
    switch (patron) {
      case "Tren Superior":
        _subPatrones = "Empuje,Traccion";
        break;
      case "Tren Inferior":
        _subPatrones = "Rodilla,Cadera";
        break;
      case "Core":
        _subPatrones = "Core";
        break;
      default:
    }

    final String url = '$apiBaseUrl/ejercicios/?patrones=$_subPatrones';
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    try {
      var results = await DefaultCacheManager().getSingleFile(url, headers: headers);

      var resultsString = await results.readAsString();
      List<dynamic> ejerciciosJson = jsonDecode(resultsString);

      List<Ejercicio> ejercicios = ejerciciosJson.map((r) => Ejercicio.fromJson(r)).toList();

      return ejercicios;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Mesociclo> postMesociclo(Mesociclo mesociclo, String token) async {
    var _mesocicloJson = mesociclo.toPostJson();
    try {
      final response = await http.post('$apiBaseUrl/mesociclos/',
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode(_mesocicloJson));
      if (response.statusCode == 200) {
        Mesociclo _mesociclo = Mesociclo.fromJson(jsonDecode(response.body));
        return _mesociclo;
      } else {
        return null;
      }
    } on Exception catch (e) {
      throw e;
    }
  }
}
