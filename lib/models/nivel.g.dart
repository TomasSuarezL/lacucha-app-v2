// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nivel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nivel _$NivelFromJson(Map<String, dynamic> json) {
  return Nivel(
    idNivel: json['idNivel'] as int,
    descripcion: json['descripcion'] as String,
  );
}

Map<String, dynamic> _$NivelToJson(Nivel instance) => <String, dynamic>{
      'idNivel': instance.idNivel,
      'descripcion': instance.descripcion,
    };
