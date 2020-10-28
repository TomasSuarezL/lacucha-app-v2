import 'package:json_annotation/json_annotation.dart';

part 'ejercicio.g.dart';

@JsonSerializable()
class Ejercicio {
  int idEjercicio;
  int repeticiones;
  double carga;
  String patron;
  String ejercicio;

  Ejercicio(
      {this.idEjercicio,
      this.repeticiones,
      this.carga,
      this.patron,
      this.ejercicio});

  factory Ejercicio.fromJson(Map<String, dynamic> json) =>
      _$EjercicioFromJson(json);

  Map<String, dynamic> toJson() => _$EjercicioToJson(this);
}
