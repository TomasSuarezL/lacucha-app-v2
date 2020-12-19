import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lacucha_app_v2/models/usuario.dart';
import 'package:lacucha_app_v2/services/usuario_service.dart';
import 'package:meta/meta.dart';

part 'usuario_event.dart';
part 'usuario_state.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  UsuarioBloc() : super(UsuarioInitial());

  @override
  Stream<UsuarioState> mapEventToState(
    UsuarioEvent event,
  ) async* {
    final currentState = state;
    if (event is UsuarioFetched) {
      try {
        if (currentState is UsuarioInitial) {
          final usuario = await UsuarioService.getUsuario(
              "tsuarezlissi"); //ToDo: HARDCODEO ACA EL USERNAME, CAMBIAR CUANDO IMPLEMENTE AUTH
          yield UsuarioSuccess(usuario: usuario);
          return;
        }
      } catch (e) {
        yield UsuarioFailure();
      }
    }
  }
}
