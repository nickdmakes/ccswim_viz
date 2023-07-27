part of 'all_swimmer_times_bloc.dart';

abstract class AllSwimmerTimesEvent extends Equatable {
  const AllSwimmerTimesEvent();

  @override
  List<Object> get props => [];
}

class FetchAllSwimmerTimes extends AllSwimmerTimesEvent {
  const FetchAllSwimmerTimes({required this.fullname, required this.club}) : super();

  final String fullname;
  final String club;

  @override
  List<Object> get props => [fullname, club];
}

class ResetAllSwimmerTimes extends AllSwimmerTimesEvent {}
