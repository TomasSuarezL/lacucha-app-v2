import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    if (event is UsuarioLogIn) {
      try {
        yield UsuarioFetching();
        if (!(currentState is UsuarioAuthenticated)) {
          String _token = await FirebaseAuth.instance.currentUser.getIdToken();
          final Usuario usuario = await UsuarioService.getUsuario(event.uuid, _token);
          if (usuario.idUsuario != null) {
            yield UsuarioAuthenticated(usuario: usuario);
          } else {
            yield UsuarioUnregistered();
          }
          return;
        } else {
          yield UsuarioAuthenticated(usuario: (currentState as UsuarioAuthenticated).usuario);
        }
      } catch (e) {
        await FirebaseAuth.instance.signOut();
        yield UsuarioFailure();
      }
    } else if (event is UsuarioUpdated) {
      yield UsuarioAuthenticated(usuario: event.usuario);
    } else if (event is UsuarioLogOut) {
      await FirebaseAuth.instance.signOut();
      yield UsuarioInitial();
    } else if (event is UsuarioFirebaseError) {
      yield UsuarioUnauthenticated(mensaje: event.mensaje);
    }
  }
}
