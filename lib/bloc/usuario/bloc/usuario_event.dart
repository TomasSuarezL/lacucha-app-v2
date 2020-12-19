part of 'usuario_bloc.dart';

@immutable
abstract class UsuarioEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UsuarioFetched extends UsuarioEvent {}
