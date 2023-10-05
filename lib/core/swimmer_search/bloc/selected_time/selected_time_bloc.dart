import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_time_state.dart';

part 'selected_time_event.dart';

class SelectedTimeBloc extends Bloc<SelectedTimeEvent, SelectedTimeState> {
  SelectedTimeBloc() : super(SelectedTimeNotSelected()) {
    on<SelectTimeClicked>(_onSelectTimeClicked);
    on<ResetTimeClicked>(_onResetTimeClicked);
  }

  void _onSelectTimeClicked(SelectTimeClicked event, Emitter<SelectedTimeState> emit) {
    emit(
      SelectedTimeSelected(
        distance: event.distance,
        stroke: event.stroke,
        time: event.time,
      ),
    );
  }

  void _onResetTimeClicked(ResetTimeClicked event, Emitter<SelectedTimeState> emit) {
    emit(SelectedTimeNotSelected());
  }
}
