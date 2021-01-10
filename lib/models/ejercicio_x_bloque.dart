import 'package:json_annotation/json_annotation.dart';
import 'package:lacucha_app_v2/models/ejercicio.dart';

part 'ejercicio_x_bloque.g.dart';

@JsonSerializable()
class EjercicioXBloque {
  int idEjerciciosxbloque;
  int repeticiones;
  double carga;
  Ejercicio ejercicio;

  EjercicioXBloque({this.idEjerciciosxbloque, this.repeticiones, this.carga, this.ejercicio});

  factory EjercicioXBloque.fromJson(Map<String, dynamic> json) => _$EjercicioXBloqueFromJson(json);

  Map<String, dynamic> toJson() => _$EjercicioXBloqueToJson(this);

  Map<String, dynamic> toPostJson() =>
      <String, dynamic>{"repeticiones": this.repeticiones, "carga": this.carga, "ejercicio": this.ejercicio.toIdJson()};
}
