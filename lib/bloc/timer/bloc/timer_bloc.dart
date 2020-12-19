import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lacucha_app_v2/services/ticker.dart';
import 'package:meta/meta.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _seconds = 0;

  StreamSubscription<int> _tickerSubscription;

  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker,
        super(TimerInitial(_seconds));

  @override
  void onTransition(Transition<TimerEvent, TimerState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStarted) {
      yield* _mapTimerStartedToState(event);
    } else if (event is TimerPaused) {
      yield* _mapTimerPausedToState(event);
    } else if (event is TimerResumed) {
      yield* _mapTimerResumedToState(event);
    } else if (event is TimerEnded) {
      yield* _mapTimerEndedToState(event);
    } else if (event is TimerTicked) {
      yield* _mapTimerTickedToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapTimerStartedToState(TimerStarted start) async* {
    yield TimerRunning(start.seconds);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: start.seconds).listen((seconds) => add(TimerTicked(seconds: seconds)));
  }

  Stream<TimerState> _mapTimerPausedToState(TimerPaused pause) async* {
    if (state is TimerRunning) {
      _tickerSubscription?.pause();
      yield TimerPause(state.seconds);
    }
  }

  Stream<TimerState> _mapTimerResumedToState(TimerResumed resume) async* {
    if (state is TimerPause) {
      _tickerSubscription?.resume();
      yield TimerRunning(state.seconds);
    }
  }

  Stream<TimerState> _mapTimerEndedToState(TimerEnded end) async* {
    if (state is TimerRunning || state is TimerPause) {
      _tickerSubscription?.cancel();
      yield TimerFinish(0);
    }
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTicked tick) async* {
    yield tick.seconds >= 0 ? TimerRunning(tick.seconds) : TimerInitial(tick.seconds);
  }
}
