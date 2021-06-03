part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {
  final int seconds;

  const TimerStarted({@required this.seconds});

  @override
  String toString() => "TimerStarted { seconds: $seconds }";
}

class TimerPaused extends TimerEvent {}

class TimerResumed extends TimerEvent {}

class TimerEnded extends TimerEvent {}

class TimerRestart extends TimerEvent {}

class TimerTicked extends TimerEvent {
  final int seconds;

  const TimerTicked({@required this.seconds});

  @override
  List<Object> get props => [seconds];

  @override
  String toString() => "TimerTicked { seconds: $seconds }";
}
