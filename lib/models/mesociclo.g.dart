// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mesociclo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mesociclo _$MesocicloFromJson(Map<String, dynamic> json) {
  return Mesociclo(
    idMesociclo: json['idMesociclo'] as int,
    usuario: json['usuario'] == null
        ? null
        : Usuario.fromJson(json['usuario'] as Map<String, dynamic>),
    estado: json['estado'] == null
        ? null
        : EstadoMesociclo.fromJson(json['estado'] as Map<String, dynamic>),
    nivel: json['nivel'] == null
        ? null
        : Nivel.fromJson(json['nivel'] as Map<String, dynamic>),
    objetivo: json['objetivo'] == null
        ? null
        : Objetivo.fromJson(json['objetivo'] as Map<String, dynamic>),
    organizacion: json['organizacion'] == null
        ? null
        : Organizacion.fromJson(json['organizacion'] as Map<String, dynamic>),
    principalTrenInferior: json['principalTrenInferior'] == null
        ? null
        : Ejercicio.fromJson(
            json['principalTrenInferior'] as Map<String, dynamic>),
    principalTrenSuperior: json['principalTrenSuperior'] == null
        ? null
        : Ejercicio.fromJson(
            json['principalTrenSuperior'] as Map<String, dynamic>),
    semanasPorMesociclo: json['semanasPorMesociclo'] as int,
    sesionesPorSemana: json['sesionesPorSemana'] as int,
    sesiones: (json['sesiones'] as List)
        ?.map((e) =>
            e == null ? null : Sesion.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..aumentoMotivacion = json['aumentoMotivacion'] as bool
    ..masCercaObjetivos = json['masCercaObjetivos'] as bool
    ..sentimiento = json['sentimiento'] as int
    ..durmiendo = json['durmiendo'] as int
    ..alimentando = json['alimentando'] as int
    ..creadoEn = json['creadoEn'] == null
        ? null
        : DateTime.parse(json['creadoEn'] as String)
    ..actualizadoEn = json['actualizadoEn'] == null
        ? null
        : DateTime.parse(json['actualizadoEn'] as String);
}

Map<String, dynamic> _$MesocicloToJson(Mesociclo instance) => <String, dynamic>{
      'idMesociclo': instance.idMesociclo,
      'usuario': instance.usuario,
      'estado': instance.estado,
      'nivel': instance.nivel,
      'objetivo': instance.objetivo,
      'organizacion': instance.organizacion,
      'principalTrenSuperior': instance.principalTrenSuperior,
      'principalTrenInferior': instance.principalTrenInferior,
      'semanasPorMesociclo': instance.semanasPorMesociclo,
      'sesionesPorSemana': instance.sesionesPorSemana,
      'sesiones': instance.sesiones,
      'aumentoMotivacion': instance.aumentoMotivacion,
      'masCercaObjetivos': instance.masCercaObjetivos,
      'sentimiento': instance.sentimiento,
      'durmiendo': instance.durmiendo,
      'alimentando': instance.alimentando,
      'creadoEn': instance.creadoEn?.toIso8601String(),
      'actualizadoEn': instance.actualizadoEn?.toIso8601String(),
    };
