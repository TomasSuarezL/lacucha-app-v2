import 'package:json_annotation/json_annotation.dart';
import 'package:lacucha_app_v2/models/bloque.dart';

part 'sesion.g.dart';

@JsonSerializable()
class Sesion {
  int idSesion;
  DateTime fechaEmpezado;
  DateTime fechaFinalizado;
  List<Bloque> bloques;

  Sesion({this.idSesion, this.fechaEmpezado, this.fechaFinalizado, this.bloques});

  factory Sesion.fromJson(Map<String, dynamic> json) => _$SesionFromJson(json);

  Map<String, dynamic> toJson() => _$SesionToJson(this);

  Map<String, dynamic> toPostJson() => <String, dynamic>{
        "fechaEmpezado": this.fechaEmpezado.toIso8601String(),
        "bloques": this.bloques.map((e) => e.toPostJson()).toList()
      };

  Map<String, dynamic> toPutJson() => <String, dynamic>{
        'idSesion': this.idSesion,
        "fechaEmpezado": this.fechaEmpezado.toIso8601String(),
        "fechaFinalizado": this.fechaEmpezado.toIso8601String(),
        "bloques": this.bloques.map((e) => e.toJson()).toList()
      };
}
