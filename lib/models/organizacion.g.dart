// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizacion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organizacion _$OrganizacionFromJson(Map<String, dynamic> json) {
  return Organizacion(
    idOrganizacion: json['idOrganizacion'] as int,
    descripcion: json['descripcion'] as String,
  );
}

Map<String, dynamic> _$OrganizacionToJson(Organizacion instance) =>
    <String, dynamic>{
      'idOrganizacion': instance.idOrganizacion,
      'descripcion': instance.descripcion,
    };
