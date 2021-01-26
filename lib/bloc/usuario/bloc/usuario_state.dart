part of 'usuario_bloc.dart';

@immutable
abstract class UsuarioState extends Equatable {
  const UsuarioState();

  @override
  List<Object> get props => [];
}

class UsuarioInitial extends UsuarioState {}

class UsuarioFailure extends UsuarioState {}

class UsuarioAuthenticated extends UsuarioState {
  final Usuario usuario;

  const UsuarioAuthenticated({
    this.usuario,
  });

  @override
  List<Object> get props => [usuario];
}

class UsuarioUnauthenticated extends UsuarioState {
  final String mensaje;

  const UsuarioUnauthenticated({
    this.mensaje,
  });

  @override
  List<Object> get props => [mensaje];
}

class UsuarioUnregistered extends UsuarioState {}

class UsuarioFetching extends UsuarioState {}
