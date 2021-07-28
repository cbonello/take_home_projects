import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../stopwatch.dart';

part 'laps_state.dart';

class LapsCubit extends Cubit<LapsState> {
  LapsCubit() : super(const LapsState(<LapModel>[]));

  void add(int hours, int minutes, int seconds) {
    final LapModel newLap = LapModel(
      lapNumber: state.laps.length + 1,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );

    if (state.laps.isEmpty) {
      emit(LapsState(<LapModel>[newLap]));
    } else {
      final LapModel lastLapAdded = state.laps.last;

      // To prevent recording of the same lap time more than once. It may happen
      // if the user clicks on the lap button more than once per second.
      if (newLap.toString() != lastLapAdded.toString()) {
        emit(LapsState(<LapModel>[...state.laps, newLap]));
      }
    }
  }

  void clear() => emit(const LapsState(<LapModel>[]));
}
