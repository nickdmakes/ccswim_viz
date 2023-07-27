part of 'all_swimmer_times_bloc.dart';

abstract class AllSwimmerTimesState extends Equatable {
  const AllSwimmerTimesState();

  @override
  List<Object> get props => [];
}

class AllSwimmerTimesFetchNotStarted extends AllSwimmerTimesState {}

class AllSwimmerTimesFetchLoading extends AllSwimmerTimesState {}

class AllSwimmerTimesFetchSuccessful extends AllSwimmerTimesState {
  const AllSwimmerTimesFetchSuccessful({required this.fullname, required this.club, required this.times}) : super();

  final String fullname;
  final String club;
  final List<dynamic> times;

  @override
  List<Object> get props => [fullname, club, times];
}

class AllSwimmerTimesFetchFailed extends AllSwimmerTimesState {}
