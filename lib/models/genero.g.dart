// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genero.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genero _$GeneroFromJson(Map<String, dynamic> json) {
  return Genero(
    idGenero: json['idGenero'] as int,
    descripcion: json['descripcion'] as String,
  );
}

Map<String, dynamic> _$GeneroToJson(Genero instance) => <String, dynamic>{
      'idGenero': instance.idGenero,
      'descripcion': instance.descripcion,
    };
