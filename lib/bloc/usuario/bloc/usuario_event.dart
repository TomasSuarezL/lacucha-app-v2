part of 'usuario_bloc.dart';

@immutable
abstract class UsuarioEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UsuarioLogIn extends UsuarioEvent {
  UsuarioLogIn({this.uuid});

  String uuid;
}

class UsuarioFirebaseError extends UsuarioEvent {
  UsuarioFirebaseError({this.mensaje});

  String mensaje;
}

class UsuarioLogOut extends UsuarioEvent {}
