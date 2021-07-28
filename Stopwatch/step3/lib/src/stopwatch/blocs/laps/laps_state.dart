part of 'laps_cubit.dart';

@immutable
class LapsState extends Equatable {
  const LapsState(this.laps);

  final List<LapModel> laps;

  @override
  List<Object?> get props => <Object?>[laps];
}
