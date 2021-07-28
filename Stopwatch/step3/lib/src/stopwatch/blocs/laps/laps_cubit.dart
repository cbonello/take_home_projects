import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../stopwatch.dart';

part 'laps_state.dart';

class LapsCubit extends Cubit<LapsState> {
  LapsCubit({
    required SharedPreferences sharedPreferences,
  })  : _sharedPreferences = sharedPreferences,
        super(const LapsState(<LapModel>[])) {
    _restart();
  }

  final SharedPreferences _sharedPreferences;
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
        final List<LapModel> newLaps = <LapModel>[...state.laps, newLap];

        // Save laps to local storage.
        try {
          final _LapsStorage lapsStorage = _LapsStorage(newLaps);
          final String data = lapsStorage.toJson();
          _sharedPreferences.setString('laps', data);
        } catch (_) {}

        emit(LapsState(newLaps));
      }
    }
  }

  void clear() => emit(const LapsState(<LapModel>[]));

  void _restart() {
    List<LapModel>? laps;

    // Try to restore laps from local storage.
    try {
      final String? data = _sharedPreferences.getString('laps');
      if (data != null) {
        final _LapsStorage lapsStorage = _LapsStorage.fromJson(data);
        laps = lapsStorage.laps;
      }
    } catch (_) {
      _sharedPreferences.remove('laps');
    }

    if (laps != null) {
      emit(LapsState(laps));
    }
  }
}

class _LapsStorage {
  _LapsStorage(this.laps);

  factory _LapsStorage.fromMap(Map<String, dynamic> map) {
    return _LapsStorage(
      List<LapModel>.from(map['laps']?.map((x) => LapModel.fromMap(x))),
    );
  }

  factory _LapsStorage.fromJson(String source) =>
      _LapsStorage.fromMap(json.decode(source));

  final List<LapModel> laps;

  Map<String, dynamic> toMap() {
    return {
      'laps': laps.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
