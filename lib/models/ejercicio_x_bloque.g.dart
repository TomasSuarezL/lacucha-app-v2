// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ejercicio_x_bloque.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EjercicioXBloque _$EjercicioXBloqueFromJson(Map<String, dynamic> json) {
  return EjercicioXBloque(
    idEjerciciosxbloque: json['idEjerciciosxbloque'] as int,
    repeticiones: json['repeticiones'] as int,
    carga: (json['carga'] as num)?.toDouble(),
    ejercicio: json['ejercicio'] == null
        ? null
        : Ejercicio.fromJson(json['ejercicio'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EjercicioXBloqueToJson(EjercicioXBloque instance) =>
    <String, dynamic>{
      'idEjerciciosxbloque': instance.idEjerciciosxbloque,
      'repeticiones': instance.repeticiones,
      'carga': instance.carga,
      'ejercicio': instance.ejercicio,
    };
