part of 'sesion_bloc.dart';

@immutable
abstract class SesionState extends Equatable {
  final Sesion sesion;

  const SesionState([this.sesion]);

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "${sesion.idSesion}: ${sesion.fechaEmpezado.toString()} - ${sesion.fechaFinalizado.toString()}";
  }
}

class SesionInitial extends SesionState {}

class SesionProxima extends SesionState {}

class SesionFailure extends SesionState {}

class SesionSuccess extends SesionState {
  const SesionSuccess(Sesion sesion) : super(sesion);

  @override
  List<Object> get props => [sesion.idSesion];
}

class SesionStart extends SesionState {
  const SesionStart(Sesion sesion) : super(sesion);

  @override
  List<Object> get props => [sesion.idSesion];
}

class SesionFinal extends SesionState {
  const SesionFinal(Sesion sesion) : super(sesion);

  @override
  List<Object> get props => [sesion.idSesion];
}
