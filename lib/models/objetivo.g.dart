// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objetivo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Objetivo _$ObjetivoFromJson(Map<String, dynamic> json) {
  return Objetivo(
    idObjetivo: json['idObjetivo'] as int,
    descripcion: json['descripcion'] as String,
  );
}

Map<String, dynamic> _$ObjetivoToJson(Objetivo instance) => <String, dynamic>{
      'idObjetivo': instance.idObjetivo,
      'descripcion': instance.descripcion,
    };
