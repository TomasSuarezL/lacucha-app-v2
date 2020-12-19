// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloque.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bloque _$BloqueFromJson(Map<String, dynamic> json) {
  return Bloque(
    idBloque: json['idBloque'] as int,
    series: json['series'] as int,
    numBloque: json['numBloque'] as int,
    ejercicios: (json['ejercicios'] as List)
        ?.map((e) => e == null
            ? null
            : EjercicioXBloque.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BloqueToJson(Bloque instance) => <String, dynamic>{
      'idBloque': instance.idBloque,
      'series': instance.series,
      'numBloque': instance.numBloque,
      'ejercicios': instance.ejercicios,
    };
