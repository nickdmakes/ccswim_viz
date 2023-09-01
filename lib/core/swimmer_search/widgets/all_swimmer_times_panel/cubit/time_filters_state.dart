part of 'time_filters_cubit.dart';

class TimeFiltersState extends Equatable {
  const TimeFiltersState({
    this.bestTimes = false,
    this.season = "All",
    this.distance = "All",
    this.stroke = "All",
  });

  final bool bestTimes;
  final String season;
  final String distance;
  final String stroke;

  @override
  List<Object> get props => [bestTimes, season, distance, stroke];

  TimeFiltersState copyWith({
    bool? bestTimes,
    String? season,
    String? distance,
    String? stroke,
  }) {
    return TimeFiltersState(
      bestTimes: bestTimes ?? this.bestTimes,
      season: season ?? this.season,
      distance: distance ?? this.distance,
      stroke: stroke ?? this.stroke,
    );
  }
}
