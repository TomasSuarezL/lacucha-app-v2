import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:lacucha_app_v2/services/train_service.dart';
import 'package:lacucha_app_v2/services/usuario_service.dart';
import 'package:meta/meta.dart';

part 'sesion_event.dart';
part 'sesion_state.dart';

class SesionBloc extends Bloc<SesionEvent, SesionState> {
  SesionBloc() : super(SesionInitial());

  @override
  Stream<SesionState> mapEventToState(
    SesionEvent event,
  ) async* {
    if (event is SesionFetched) {
      yield* _mapSesionFetchedToState(event);
    } else if (event is SesionStarted) {
      yield* _mapSesionStartedToState(event);
    } else if (event is SesionFinished) {
      yield* _mapSesionFinishedToState(event);
    } else if (event is SesionNext) {
      yield* _mapSesionNextToState(event);
    }
  }

  Stream<SesionState> _mapSesionFetchedToState(SesionFetched fetch) async* {
    try {
      if (state is SesionInitial) {
        final sesion = await UsuarioService.getSesionDeHoy(fetch.idUsuario);
        if (sesion.idSesion == null) {
          yield SesionProxima();
        } else if (sesion.fechaFinalizado != null) {
          yield SesionFinal(sesion);
        } else {
          yield SesionSuccess(sesion);
        }
        return;
      }
    } catch (e) {
      yield SesionFailure();
    }
  }

  Stream<SesionState> _mapSesionStartedToState(SesionStarted start) async* {
    try {
      if (state is SesionSuccess) {
        state.sesion.fechaEmpezado = DateTime.now();
        yield SesionStart(state.sesion);
        return;
      }
    } catch (e) {
      yield SesionFailure();
    }
  }

  Stream<SesionState> _mapSesionFinishedToState(SesionFinished finish) async* {
    try {
      if (state is SesionStart) {
        state.sesion.fechaFinalizado = DateTime.now();
        // Put Sesion finalizada, finish.sesion
        var result = await TrainService.putSesion(state.sesion);
        if (result) {
          yield SesionFinal(state.sesion);
        } else {
          yield SesionFailure();
        }
        return;
      } else if (state is SesionInitial) {
        yield SesionFinal(finish.sesion);
      }
    } catch (e) {
      yield SesionFailure();
    }
  }

  Stream<SesionState> _mapSesionNextToState(SesionNext next) async* {
    try {
      if (state is SesionFinal || state is SesionProxima) {
        final sesion = await UsuarioService.getProximaSesion(next.idUsuario);
        yield SesionSuccess(sesion);
        return;
      }
    } catch (e) {
      yield SesionFailure();
    }
  }
}
