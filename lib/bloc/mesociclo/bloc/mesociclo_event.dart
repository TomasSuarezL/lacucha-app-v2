part of 'mesociclo_bloc.dart';

@immutable
abstract class MesocicloEvent extends Equatable {
  const MesocicloEvent();

  @override
  List<Object> get props => [];
}

class MesocicloFetched extends MesocicloEvent {
  final int idUsuario;

  const MesocicloFetched({@required this.idUsuario});
}

class MesocicloCreated extends MesocicloEvent {
  final Mesociclo mesociclo;

  const MesocicloCreated({@required this.mesociclo});
}


class MesocicloEnded extends MesocicloEvent {
  final Mesociclo mesociclo;
  const MesocicloEnded({this.mesociclo});
}

class SesionUpdated extends MesocicloEvent {
  final Bloque bloque;

  const SesionUpdated({@required this.bloque});
}

class SesionStarted extends MesocicloEvent {
  const SesionStarted();
}

class SesionEnded extends MesocicloEvent {
  final Sesion sesion;
  const SesionEnded({this.sesion});
}

class SesionNext extends MesocicloEvent {
  final int idUsuario;

  const SesionNext({@required this.idUsuario});
}
