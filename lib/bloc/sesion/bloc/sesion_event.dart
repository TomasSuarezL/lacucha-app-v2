part of 'sesion_bloc.dart';

@immutable
abstract class SesionEvent extends Equatable {
  const SesionEvent();

  @override
  List<Object> get props => [];
}

class SesionFetched extends SesionEvent {
  final int idUsuario;

  const SesionFetched({@required this.idUsuario});
}

class SesionStarted extends SesionEvent {
  const SesionStarted();
}

class SesionFinished extends SesionEvent {
  final Sesion sesion;
  const SesionFinished({this.sesion});
}

class SesionNext extends SesionEvent {
  final int idUsuario;

  const SesionNext({@required this.idUsuario});
}
