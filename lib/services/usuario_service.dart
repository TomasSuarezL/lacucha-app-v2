import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:lacucha_app_v2/constants.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/models/nivel.dart';
import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:lacucha_app_v2/models/usuario.dart';

class UsuarioService {
  static Usuario _usuario = Usuario(
      nombre: "Martin",
      apellido: "Sampo",
      email: "msampo@lacucha.com",
      username: "@msampo",
      altura: 1.70,
      peso: 99,
      fechaNacimiento: new DateTime(1989, 8, 22),
      genero: "M",
      nivel: Nivel.principiante,
      imgUrl: "assets/Perro.jpeg");

  static getUsuarioSynthetic() {
    return _usuario;
  }

  static Future<Usuario> getUsuario(String username) async {
    final response = await http.get('$apiBaseUrl/usuarios/$username');
    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener Usuario.');
    }
  }

  static Future<Mesociclo> getMesocicloActivo(int idUsuario) async {
    final response = await http.get('$apiBaseUrl/usuarios/$idUsuario/mesociclos?activo=true');
    if (response.statusCode == 200) {
      return Mesociclo.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception('Error al obtener el Mesociclo. ${response.statusCode}');
    }
  }

  static Future<Sesion> getSesionDeHoy(int idUsuario) async {
    final response = await http.get('$apiBaseUrl/usuarios/$idUsuario/mesociclos/sesionHoy');
    if (response.statusCode == 200) {
      return Sesion.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener la Sesión de Hoy. ${response.statusCode}');
    }
  }

  static Future<Sesion> getProximaSesion(int idUsuario) async {
    final response = await http.get('$apiBaseUrl/usuarios/$idUsuario/mesociclos/proximaSesion');
    if (response.statusCode == 200) {
      return Sesion.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener la Próxima Sesión. ${response.statusCode}');
    }
  }
}
