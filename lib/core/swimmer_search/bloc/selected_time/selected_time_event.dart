part of 'selected_time_bloc.dart';

abstract class SelectedTimeEvent extends Equatable {
  const SelectedTimeEvent();

  @override
  List<Object> get props => [];
}

class SelectTimeClicked extends SelectedTimeEvent {
  const SelectTimeClicked({required this.distance, required this.stroke, required this.time}) : super();

  final String distance;
  final String stroke;
  final String time;

  @override
  List<Object> get props => [distance, stroke, time];
}

class ResetTimeClicked extends SelectedTimeEvent {}
