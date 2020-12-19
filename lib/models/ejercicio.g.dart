// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ejercicio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ejercicio _$EjercicioFromJson(Map<String, dynamic> json) {
  return Ejercicio(
    idEjercicio: json['idEjercicio'] as int,
    patron: json['patron'] as String,
    nombre: json['nombre'] as String,
  );
}

Map<String, dynamic> _$EjercicioToJson(Ejercicio instance) => <String, dynamic>{
      'idEjercicio': instance.idEjercicio,
      'patron': instance.patron,
      'nombre': instance.nombre,
    };
