import 'package:json_annotation/json_annotation.dart';
import 'package:lacucha_app_v2/models/genero.dart';
import 'package:lacucha_app_v2/models/nivel.dart';

part 'usuario.g.dart';

@JsonSerializable()
class Usuario {
  int idUsuario;
  String uuid;
  String nombre;
  String apellido;
  String email;
  String username;
  String imgUrl;
  DateTime fechaNacimiento;
  Genero genero;
  double altura;
  double peso;
  Nivel nivel;

  Usuario(
      {this.idUsuario,
      this.uuid,
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

  Map<String, dynamic> toPostJson() => <String, dynamic>{
        'uuid': this.uuid,
        'nombre': this.nombre,
        'apellido': this.apellido,
        'email': this.email,
        'username': this.username,
        'imgUrl': this.imgUrl,
        'fechaNacimiento': this.fechaNacimiento?.toIso8601String(),
        'genero': this.genero.toIdJson(),
        'peso': this.peso,
        'altura': this.altura,
        'nivel': this.nivel.toIdJson(),
      };
}
