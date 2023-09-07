import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'time_filters_state.dart';

class TimeFiltersCubit extends Cubit<TimeFiltersState> {
  TimeFiltersCubit() : super(const TimeFiltersState());

  void bestTimesToggled(bool value) {
    emit(state.copyWith(bestTimes: value));
  }

  void seasonChanged(String value) {
    emit(state.copyWith(season: value));
  }

  void distanceChanged(String value) {
    emit(state.copyWith(distance: value));
  }

  void strokeChanged(String value) {
    emit(state.copyWith(stroke: value));
  }
}
