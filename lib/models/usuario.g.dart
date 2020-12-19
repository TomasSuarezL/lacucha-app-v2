// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) {
  return Usuario(
    idUsuario: json['idUsuario'] as int,
    nombre: json['nombre'] as String,
    apellido: json['apellido'] as String,
    email: json['email'] as String,
    username: json['username'] as String,
    imgUrl: json['imgUrl'] as String,
    fechaNacimiento: json['fechaNacimiento'] == null
        ? null
        : DateTime.parse(json['fechaNacimiento'] as String),
    genero: json['genero'] as String,
    altura: (json['altura'] as num)?.toDouble(),
    peso: (json['peso'] as num)?.toDouble(),
    nivel: json['nivel'] as String,
  );
}

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      'idUsuario': instance.idUsuario,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'email': instance.email,
      'username': instance.username,
      'imgUrl': instance.imgUrl,
      'fechaNacimiento': instance.fechaNacimiento?.toIso8601String(),
      'genero': instance.genero,
      'altura': instance.altura,
      'peso': instance.peso,
      'nivel': instance.nivel,
    };
