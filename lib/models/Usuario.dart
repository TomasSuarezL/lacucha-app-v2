import 'package:json_annotation/json_annotation.dart';
import 'package:lacucha_app_v2/models/nivel.dart';

part 'usuario.g.dart';

@JsonSerializable()
class Usuario {
  int idUsuario;
  String nombre;
  String apellido;
  String email;
  String username;
  String imgUrl;
  DateTime fechaNacimiento;
  String genero;
  double altura;
  double peso;
  Nivel nivel;

  Usuario(
      {this.idUsuario,
      this.nombre,
      this.apellido,
      this.email,
      this.username,
      this.imgUrl,
      this.fechaNacimiento,
      this.genero,
      this.altura,
      this.peso,
      this.nivel});

  factory Usuario.fromJson(Map<String, dynamic> json) => _$UsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$UsuarioToJson(this);

  Map<String, dynamic> toIdJson() => <String, dynamic>{"idUsuario": this.idUsuario};
}
