import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'stopwatch_state.dart';

class StopwatchCubit extends Cubit<StopwatchState> {
  StopwatchCubit({
    required SharedPreferences sharedPreferences,
  })  : _sharedPreferences = sharedPreferences,
        super(const StopwatchState()) {
    _restart();
  }

  final SharedPreferences _sharedPreferences;

  // Remember when the stopwatch was started.
  late DateTime _startTime;

  StreamSubscription<void>? _tickerSub;

  bool get isRunning => _tickerSub != null;

  void start() {
    assert(!isRunning);

    // Reset display.
    emit(const StopwatchState(hours: 0, minutes: 0, seconds: 0));

    _startTime = DateTime.now();

    // Save start time in local storage.
    final int timestamp = _startTime.millisecondsSinceEpoch;
    _sharedPreferences.setInt('start_time', timestamp);

    _startStopwatch();
  }

  void _restart() {
    int? timestamp;

    // Stopwatch was running when it was closed if a start time is stored in
    // local storage.
    try {
      // May throw an exception in the unlikely event the timestamp is not
      // stored as an int.
      timestamp = _sharedPreferences.getInt('start_time');
    } catch (_) {
      _sharedPreferences.remove('start_time');
    }

    if (timestamp != null) {
      // Automatically restart the stopwatch.
      _startTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      _startStopwatch();
    }
  }

  void _startStopwatch() {
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

    // Delete start time from local storage to prevent an automatic restart
    // during the next app startup.
    _sharedPreferences.remove('start_time');

    _tickerSub?.cancel();
    _tickerSub = null;
  }

  @override
  Future<void> close() async {
    _tickerSub?.cancel();
    super.close();
  }
}
