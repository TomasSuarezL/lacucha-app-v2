import 'package:json_annotation/json_annotation.dart';
import 'package:lacucha_app_v2/models/ejercicio_x_bloque.dart';

part 'bloque.g.dart';

@JsonSerializable()
class Bloque {
  int idBloque;
  int series;
  int numBloque;
  List<EjercicioXBloque> ejercicios;

  Bloque({this.idBloque, this.series, this.numBloque, this.ejercicios});

  factory Bloque.fromJson(Map<String, dynamic> json) => _$BloqueFromJson(json);

  Map<String, dynamic> toJson() => _$BloqueToJson(this);
}
