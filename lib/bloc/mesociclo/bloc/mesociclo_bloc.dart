import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:lacucha_app_v2/models/bloque.dart';
import 'package:lacucha_app_v2/models/mesociclo.dart';
import 'package:lacucha_app_v2/models/sesion.dart';
import 'package:lacucha_app_v2/services/helpers.dart';
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
      yield* _mapSesionEndedToState(event);
    } else if (event is SesionNext) {
      yield* _mapSesionNextToState(event);
    } else if (event is SesionUpdated) {
      yield* _mapSesionUpdatedToState(event);
    }
  }

  Stream<MesocicloState> _mapMesocicloFetchedToState(MesocicloFetched fetch) async* {
    try {
      yield MesocicloFetching();
      String _token = await FirebaseAuth.instance.currentUser.getIdToken();
      final mesociclo = await UsuarioService.getMesocicloActivo(fetch.idUsuario, _token);
      if (mesociclo.idMesociclo == null) {
        yield MesocicloEmpty();
        return;
      }
      Sesion sesionHoy =
          mesociclo.sesiones.firstWhere((s) => isSameDay(s.fechaEmpezado, DateTime.now()), orElse: () => null);
      if (sesionHoy == null) {
        if (mesociclo.proximaSesion == null) {
          yield MesocicloFinal(mesociclo);
        } else {
          yield MesocicloSesionProxima(mesociclo, sesionHoy);
        }
      } else if (sesionHoy?.fechaFinalizado != null) {
        yield MesocicloSesionFinal(mesociclo, sesionHoy);
      } else {
        yield MesocicloSuccess(mesociclo, sesionHoy);
      }
      return;
    } catch (e) {
      yield MesocicloFailure();
    }
  }

  Stream<MesocicloState> _mapMesocicloCreatedToState(MesocicloCreated create) async* {
    try {
      if (state is MesocicloEmpty) {
        yield MesocicloFetching();

        String _token = await FirebaseAuth.instance.currentUser.getIdToken();
        Mesociclo _mesociclo = await TrainService.postMesociclo(create.mesociclo, _token);
        Sesion _sesionHoy = _mesociclo.sesiones
            .firstWhere((s) => s.fechaEmpezado.difference(DateTime.now()).inDays == 0, orElse: () => null);

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

  Stream<MesocicloState> _mapSesionEndedToState(SesionEnded finish) async* {
    try {
      Mesociclo currentMesociclo = state.mesociclo;
      Sesion currentSesion = state.sesionActual;
      yield MesocicloFetching();
      if (state is MesocicloSesionStart) {
        currentSesion.fechaFinalizado = DateTime.now();
        String _token = await FirebaseAuth.instance.currentUser.getIdToken();
        var result = await TrainService.putSesion(currentSesion, _token);
        if (result) {
          if (currentMesociclo.proximaSesion == null) {
            // No hay proxima sesion en el mesociclo -> mesociclo finalizado
            yield MesocicloFinal(currentMesociclo);
          } else {
            yield MesocicloSesionFinal(currentMesociclo, currentSesion);
          }
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

  Stream<MesocicloState> _mapSesionUpdatedToState(SesionUpdated update) async* {
    try {
      if (state is MesocicloSuccess) {
        yield MesocicloFetching();
        //state.sesionActual.bloques[update.bloque.numBloque] = update.bloque;
        yield MesocicloSuccess(state.mesociclo, state.sesionActual);
        return;
      }
    } catch (e) {
      yield MesocicloFailure();
    }
  }
}
