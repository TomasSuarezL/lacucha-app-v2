part of 'timer_bloc.dart';

@immutable
abstract class TimerState extends Equatable {
  final int seconds;

  const TimerState(this.seconds);

  @override
  List<Object> get props => [seconds];
}

class TimerInitial extends TimerState {
  const TimerInitial(int seconds) : super(seconds);

  @override
  String toString() => 'TimerInitial { seconds: $seconds }';
}

class TimerPause extends TimerState {
  const TimerPause(int seconds) : super(seconds);

  @override
  String toString() => 'TimerPause { seconds: $seconds }';
}

class TimerRunning extends TimerState {
  const TimerRunning(int seconds) : super(seconds);

  @override
  String toString() => 'TimerRunning { seconds: $seconds }';
}

class TimerFinish extends TimerState {
  const TimerFinish(int seconds) : super(seconds);
}
