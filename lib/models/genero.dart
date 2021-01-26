import 'package:json_annotation/json_annotation.dart';

part 'genero.g.dart';

@JsonSerializable()
class Genero {
  final int idGenero;
  final String descripcion;

  const Genero({this.idGenero, this.descripcion});

  factory Genero.fromJson(Map<String, dynamic> json) => _$GeneroFromJson(json);

  Map<String, dynamic> toJson() => _$GeneroToJson(this);

  Map<String, dynamic> toIdJson() => <String, dynamic>{"idGenero": this.idGenero};

  static const Genero masculino = Genero(idGenero: 1, descripcion: "Masculino");
  static const Genero femenino = Genero(idGenero: 2, descripcion: "Femenino");
  static const Genero otro = Genero(idGenero: 3, descripcion: "Otro");
}
