import 'package:json_annotation/json_annotation.dart';

part 'nivel.g.dart';

@JsonSerializable()
class Nivel {
  final int idNivel;
  final String descripcion;

  const Nivel({this.idNivel, this.descripcion});

  factory Nivel.fromJson(Map<String, dynamic> json) => _$NivelFromJson(json);

  Map<String, dynamic> toJson() => _$NivelToJson(this);

  Map<String, dynamic> toIdJson() => <String, dynamic>{"idNivel": this.idNivel};

  static const Nivel principiante = Nivel(idNivel: 1, descripcion: "Principiante");
  static const Nivel intermedio = Nivel(idNivel: 2, descripcion: "Intermedio");
  static const Nivel avanzado = Nivel(idNivel: 3, descripcion: "Avanzado");
}
