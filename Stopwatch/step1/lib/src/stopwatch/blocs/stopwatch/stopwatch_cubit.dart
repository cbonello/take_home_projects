import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';

part 'stopwatch_state.dart';

class StopwatchCubit extends Cubit<StopwatchState> {
  StopwatchCubit() : super(const StopwatchState());

  // Remember when the stopwatch was started.
  late DateTime _startTime;

  StreamSubscription<void>? _tickerSub;

  bool get isRunning => _tickerSub != null;

  void start() {
    assert(!isRunning);

    // Reset display.
    emit(const StopwatchState(hours: 0, minutes: 0, seconds: 0));

    _startTime = DateTime.now();
    _tickerSub = Stream<void>.periodic(const Duration(seconds: 1)).listen(
      (_) {
        final DateTime currentTime = DateTime.now();
        final Duration difference = currentTime.difference(_startTime);

        int seconds = difference.inSeconds;
        final int hours = seconds ~/ Duration.secondsPerHour;
        seconds -= hours * Duration.secondsPerHour;
        final int minutes = seconds ~/ Duration.secondsPerMinute;
        seconds -= minutes * Duration.secondsPerMinute;

        emit(StopwatchState(hours: hours, minutes: minutes, seconds: seconds));
      },
    );
  }

  void stop() {
    assert(isRunning);

    _tickerSub?.cancel();
    _tickerSub = null;
  }

  @override
  Future<void> close() async {
    _tickerSub?.cancel();
    super.close();
  }
}
