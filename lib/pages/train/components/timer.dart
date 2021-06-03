import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacucha_app_v2/bloc/mesociclo/bloc/mesociclo_bloc.dart';
import 'package:lacucha_app_v2/bloc/timer/bloc.dart';
import 'package:lacucha_app_v2/pages/train/components/timer_button.dart';

class Timer extends StatelessWidget {
  const Timer({Key key}) : super(key: key);

  Widget _timerControls(BuildContext context) {
    TimerBloc _timerBloc = BlocProvider.of<TimerBloc>(context);
    if (_timerBloc.state is TimerRunning) {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        PauseButton(onPressed: () => _timerBloc.add(TimerPaused())),
        StopButton(onPressed: () => _timerBloc.add(TimerEnded()))
      ]);
    } else if (_timerBloc.state is TimerPause) {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        PlayButton(onPressed: () => _timerBloc.add(TimerResumed())),
        StopButton(onPressed: () => _timerBloc.add(TimerEnded())),
      ]);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Colors.grey[200],
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: BlocConsumer<TimerBloc, TimerState>(
            listener: (context, state) {
              if (state is TimerFinish) {
                BlocProvider.of<MesocicloBloc>(context).add(SesionEnded());
                BlocProvider.of<TimerBloc>(context).add(TimerRestart());
              }
            },
            builder: (context, state) {
              String _horas = (state.seconds / 60 / 60).floor().toString();
              String _minutos = (((state.seconds / 60) % 60)).floor().toString();
              String _segundos = ((state.seconds % 60)).floor().toString();
              if (state is! TimerInitial) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: [
                      Text(
                        "${_horas.padLeft(2, '0')}:${_minutos.padLeft(2, '0')}:${_segundos.padLeft(2, '0')}",
                        style: Theme.of(context).textTheme.headline5.apply(color: Theme.of(context).primaryColor),
                      ),
                    ]),
                    _timerControls(context),
                  ],
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
