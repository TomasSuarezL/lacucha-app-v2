part of 'usuario_bloc.dart';

@immutable
abstract class UsuarioState extends Equatable {
  const UsuarioState();

  @override
  List<Object> get props => [];
}

class UsuarioInitial extends UsuarioState {}

class UsuarioFailure extends UsuarioState {}

class UsuarioSuccess extends UsuarioState {
  final Usuario usuario;

  const UsuarioSuccess({
    this.usuario,
  });

  @override
  List<Object> get props => [usuario];
}
