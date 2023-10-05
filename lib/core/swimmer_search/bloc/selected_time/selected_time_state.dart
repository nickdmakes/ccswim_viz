part of 'selected_time_bloc.dart';

abstract class SelectedTimeState extends Equatable {
  const SelectedTimeState();

  @override
  List<Object> get props => [];
}

class SelectedTimeNotSelected extends SelectedTimeState {}

class SelectedTimeSelected extends SelectedTimeState {
  const SelectedTimeSelected({required this.distance, required this.stroke, required this.time}) : super();

  final String distance;
  final String stroke;
  final String time;

  @override
  List<Object> get props => [distance, stroke, time];
}
