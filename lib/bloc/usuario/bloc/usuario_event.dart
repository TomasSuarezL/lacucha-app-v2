part of 'usuario_bloc.dart';

@immutable
abstract class UsuarioEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UsuarioLogIn extends UsuarioEvent {
  UsuarioLogIn({this.uuid});

  final String uuid;
}

class UsuarioUpdated extends UsuarioEvent {
  UsuarioUpdated({this.usuario});

  final Usuario usuario;
}

class UsuarioFirebaseError extends UsuarioEvent {
  UsuarioFirebaseError({this.mensaje});

  final String mensaje;
}

class UsuarioLogOut extends UsuarioEvent {}
