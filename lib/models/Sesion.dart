import 'package:json_annotation/json_annotation.dart';
import 'package:lacucha_app_v2/models/bloque.dart';

part 'sesion.g.dart';

@JsonSerializable()
class Sesion {
  int idSesion;
  DateTime fechaEmpezado;
  DateTime fechaFinalizado;
  List<Bloque> bloques;

  Sesion(
      {this.idSesion, this.fechaEmpezado, this.fechaFinalizado, this.bloques});

  factory Sesion.fromJson(Map<String, dynamic> json) => _$SesionFromJson(json);

  Map<String, dynamic> toJson() => _$SesionToJson(this);
}
