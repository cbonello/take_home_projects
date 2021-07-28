import 'dart:convert';

class LapModel {
  LapModel({
    required this.lapNumber,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  final int lapNumber;
  final int hours;
  final int minutes;
  final int seconds;

  Map<String, dynamic> toMap() {
    return {
      'lapNumber': lapNumber,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
    };
  }

  factory LapModel.fromMap(Map<String, dynamic> map) {
    return LapModel(
      lapNumber: map['lapNumber'],
      hours: map['hours'],
      minutes: map['minutes'],
      seconds: map['seconds'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LapModel.fromJson(String source) =>
      LapModel.fromMap(json.decode(source));

  @override
  String toString() =>
      '${_format(hours)}:${_format(minutes)}:${_format(seconds)}';

  String _format(int value) => value.toString().padLeft(2, '0');
}
