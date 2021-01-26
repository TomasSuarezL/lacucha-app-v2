part of 'mesociclo_bloc.dart';

@immutable
abstract class MesocicloState extends Equatable {
  final Mesociclo mesociclo;
  final Sesion sesionActual;

  const MesocicloState([this.mesociclo, this.sesionActual]);

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "${mesociclo.idMesociclo}";
  }
}

class MesocicloInitial extends MesocicloState {}

class MesocicloSesionProxima extends MesocicloState {
  const MesocicloSesionProxima(Mesociclo mesociclo, Sesion proximaSesion) : super(mesociclo, proximaSesion);

  @override
  List<Object> get props => [mesociclo.idMesociclo];
}

class MesocicloFailure extends MesocicloState {}

class MesocicloSuccess extends MesocicloState {
  const MesocicloSuccess(Mesociclo mesociclo, Sesion proximaSesion) : super(mesociclo, proximaSesion);

  @override
  List<Object> get props => [mesociclo.idMesociclo];
}

class MesocicloSesionStart extends MesocicloState {
  const MesocicloSesionStart(Mesociclo mesociclo, Sesion proximaSesion) : super(mesociclo, proximaSesion);

  @override
  List<Object> get props => [mesociclo.idMesociclo];
}

class MesocicloSesionFinal extends MesocicloState {
  const MesocicloSesionFinal(Mesociclo mesociclo, Sesion proximaSesion) : super(mesociclo, proximaSesion);

  @override
  List<Object> get props => [mesociclo.idMesociclo];
}

class MesocicloEmpty extends MesocicloState {}

class MesocicloFetching extends MesocicloState {}
