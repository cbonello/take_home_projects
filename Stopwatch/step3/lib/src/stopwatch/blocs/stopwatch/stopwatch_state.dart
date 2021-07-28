part of 'stopwatch_cubit.dart';

@immutable
class StopwatchState extends Equatable {
  const StopwatchState({
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
  });

  final int hours;
  final int minutes;
  final int seconds;

  String _format(int value) => value.toString().padLeft(2, '0');

  @override
  String toString() =>
      '${_format(hours)}:${_format(minutes)}:${_format(seconds)}';

  @override
  List<Object?> get props => <Object?>[hours, minutes, seconds];
}
