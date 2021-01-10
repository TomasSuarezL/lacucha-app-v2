import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:lacucha_app_v2/services/train_service.dart';
import 'package:lacucha_app_v2/services/usuario_service.dart';
import 'package:meta/meta.dart';

part 'mesociclo_event.dart';
part 'mesociclo_state.dart';

class MesocicloBloc extends Bloc<MesocicloEvent, MesocicloState> {
  MesocicloBloc() : super(MesocicloInitial());

  @override
  Stream<MesocicloState> mapEventToState(
    MesocicloEvent event,
  ) async* {
    if (event is MesocicloFetched) {
      yield* _mapMesocicloFetchedToState(event);
    } else if (event is MesocicloCreated) {
      yield* _mapMesocicloCreatedToState(event);
    } else if (event is SesionStarted) {
      yield* _mapSesionStartedToState(event);
    } else if (event is SesionEnded) {
      yield* _mapSesionFinishedToState(event);
    } else if (event is SesionNext) {
      yield* _mapSesionNextToState(event);
    }
  }

  Stream<MesocicloState> _mapMesocicloFetchedToState(MesocicloFetched fetch) async* {
    try {
      if (state is MesocicloInitial) {
        final mesociclo = await UsuarioService.getMesocicloActivo(fetch.idUsuario);
        if (mesociclo.idMesociclo == null) {
          yield MesocicloEmpty();
          return;
        }
        Sesion sesionHoy = mesociclo.sesiones.firstWhere((s) => s.fechaEmpezado.difference(DateTime.now()).inDays == 0, orElse: () => null);
        if (sesionHoy == null) {
          yield MesocicloSesionProxima(mesociclo, sesionHoy);
        } else if (sesionHoy?.fechaFinalizado != null) {
          yield MesocicloSesionFinal(mesociclo, sesionHoy);
        } else {
          yield MesocicloSuccess(mesociclo, sesionHoy);
        }
        return;
      }
    } catch (e) {
      yield MesocicloFailure();
    }
  }

  Stream<MesocicloState> _mapMesocicloCreatedToState(MesocicloCreated create) async* {
    try {
      if (state is MesocicloEmpty) {
        Mesociclo _mesociclo = await TrainService.postMesociclo(create.mesociclo);
        Sesion _sesionHoy =
            _mesociclo.sesiones.firstWhere((s) => s.fechaEmpezado.difference(DateTime.now()).inDays == 0, orElse: () => null);

        if (_sesionHoy == null) {
          yield MesocicloSesionProxima(_mesociclo, _sesionHoy);
        } else {
          yield MesocicloSuccess(_mesociclo, _sesionHoy);
        }
      }
    } catch (e) {
      yield MesocicloEmpty();
    }
  }

  Stream<MesocicloState> _mapSesionStartedToState(SesionStarted start) async* {
    try {
      if (state is MesocicloSuccess) {
        state.sesionActual.fechaEmpezado = DateTime.now();
        yield MesocicloSesionStart(state.mesociclo, state.sesionActual);
        return;
      }
    } catch (e) {
      yield MesocicloFailure();
    }
  }

  Stream<MesocicloState> _mapSesionFinishedToState(SesionEnded finish) async* {
    try {
      if (state is MesocicloSesionStart) {
        state.sesionActual.fechaFinalizado = DateTime.now();
        // Put Sesion finalizada, finish.sesion
        var result = await TrainService.putSesion(state.sesionActual);
        if (result) {
          yield MesocicloSesionFinal(state.mesociclo, state.sesionActual);
        } else {
          yield MesocicloFailure();
        }
        return;
      } else if (state is MesocicloInitial) {
        yield MesocicloSesionFinal(state.mesociclo, finish.sesion);
      }
    } catch (e) {
      yield MesocicloFailure();
    }
  }

  Stream<MesocicloState> _mapSesionNextToState(SesionNext next) async* {
    try {
      if (state is MesocicloSesionFinal || state is MesocicloSesionProxima) {
        var _proximasSesiones = state.mesociclo.sesiones.where((s) => s.fechaFinalizado == null).toList();
        _proximasSesiones.sort((a, b) => a.fechaEmpezado.compareTo(b.fechaEmpezado));
        final _proximaSesion = _proximasSesiones[0];
        yield MesocicloSuccess(state.mesociclo, _proximaSesion);
        return;
      }
    } catch (e) {
      yield MesocicloFailure();
    }
  }
}
