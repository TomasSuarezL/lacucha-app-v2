import 'package:json_annotation/json_annotation.dart';

part 'organizacion.g.dart';

@JsonSerializable()
class Organizacion {
  final int idOrganizacion;
  final String descripcion;

  const Organizacion({this.idOrganizacion, this.descripcion});

  factory Organizacion.fromJson(Map<String, dynamic> json) => _$OrganizacionFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizacionToJson(this);

  Map<String, dynamic> toIdJson() => <String, dynamic>{"idOrganizacion": this.idOrganizacion};

  static const Organizacion full_body = Organizacion(idOrganizacion: 1, descripcion: "Full Body");
  static const Organizacion tren_superior_inferior = Organizacion(idOrganizacion: 2, descripcion: "Tren Superior / Tren Inferior");
  static const Organizacion combinado = Organizacion(idOrganizacion: 3, descripcion: "Combinado");
}
