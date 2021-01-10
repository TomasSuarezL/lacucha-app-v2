import 'package:json_annotation/json_annotation.dart';

part 'estado_mesociclo.g.dart';

@JsonSerializable()
class EstadoMesociclo {
  final int idEstadoMesociclo;
  final String descripcion;

  const EstadoMesociclo({this.idEstadoMesociclo, this.descripcion});

  factory EstadoMesociclo.fromJson(Map<String, dynamic> json) => _$EstadoMesocicloFromJson(json);

  Map<String, dynamic> toJson() => _$EstadoMesocicloToJson(this);

  Map<String, dynamic> toIdJson() => <String, dynamic>{"idEstadoMesociclo": this.idEstadoMesociclo};

  static const EstadoMesociclo activo = EstadoMesociclo(idEstadoMesociclo: 1, descripcion: "Activo");
  static const EstadoMesociclo terminado = EstadoMesociclo(idEstadoMesociclo: 2, descripcion: "Terminado");
  static const EstadoMesociclo cancelado = EstadoMesociclo(idEstadoMesociclo: 3, descripcion: "Cancelado");
}
