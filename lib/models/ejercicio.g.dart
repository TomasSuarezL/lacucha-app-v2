// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ejercicio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ejercicio _$EjercicioFromJson(Map<String, dynamic> json) {
  return Ejercicio(
    idEjercicio: json['idEjercicio'] as int,
    repeticiones: json['repeticiones'] as int,
    carga: (json['carga'] as num)?.toDouble(),
    patron: json['patron'] as String,
    ejercicio: json['ejercicio'] as String,
  );
}

Map<String, dynamic> _$EjercicioToJson(Ejercicio instance) => <String, dynamic>{
      'idEjercicio': instance.idEjercicio,
      'repeticiones': instance.repeticiones,
      'carga': instance.carga,
      'patron': instance.patron,
      'ejercicio': instance.ejercicio,
    };
