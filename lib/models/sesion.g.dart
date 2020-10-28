// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sesion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sesion _$SesionFromJson(Map<String, dynamic> json) {
  return Sesion(
    idSesion: json['idSesion'] as int,
    fechaEmpezado: json['fechaEmpezado'] == null
        ? null
        : DateTime.parse(json['fechaEmpezado'] as String),
    fechaFinalizado: json['fechaFinalizado'] == null
        ? null
        : DateTime.parse(json['fechaFinalizado'] as String),
    bloques: (json['bloques'] as List)
        ?.map((e) =>
            e == null ? null : Bloque.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SesionToJson(Sesion instance) => <String, dynamic>{
      'idSesion': instance.idSesion,
      'fechaEmpezado': instance.fechaEmpezado?.toIso8601String(),
      'fechaFinalizado': instance.fechaFinalizado?.toIso8601String(),
      'bloques': instance.bloques,
    };
