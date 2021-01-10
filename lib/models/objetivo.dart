import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'objetivo.g.dart';

@JsonSerializable()
class Objetivo extends Equatable {
  final int idObjetivo;
  final String descripcion;

  const Objetivo({this.idObjetivo, this.descripcion});

  factory Objetivo.fromJson(Map<String, dynamic> json) => _$ObjetivoFromJson(json);

  Map<String, dynamic> toJson() => _$ObjetivoToJson(this);

  Map<String, dynamic> toIdJson() => <String, dynamic>{"idObjetivo": this.idObjetivo};

  static const Objetivo acondicionamiento_general = Objetivo(idObjetivo: 1, descripcion: "Acondicionamiento General");
  static const Objetivo hipertrofia = Objetivo(idObjetivo: 2, descripcion: "Hipertrofia");
  static const Objetivo fuerza = Objetivo(idObjetivo: 3, descripcion: "Fuerza");

  @override
  List<Object> get props => [idObjetivo];
}
