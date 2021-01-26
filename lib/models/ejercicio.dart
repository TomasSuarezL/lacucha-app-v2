import 'package:json_annotation/json_annotation.dart';

part 'ejercicio.g.dart';

@JsonSerializable()
class Ejercicio {
  int idEjercicio;
  String patron;
  String nombre;
  String urlVideo;

  Ejercicio({this.idEjercicio, this.patron, this.nombre, this.urlVideo});

  factory Ejercicio.fromJson(Map<String, dynamic> json) => _$EjercicioFromJson(json);

  Map<String, dynamic> toJson() => _$EjercicioToJson(this);

  Map<String, dynamic> toIdJson() => <String, dynamic>{"idEjercicio": this.idEjercicio};
}
