part of 'swimmer_search_bloc.dart';

abstract class SwimmerSearchState extends Equatable {
  const SwimmerSearchState();

  @override
  List<Object> get props => [];
}

class SwimmerSearchNotStarted extends SwimmerSearchState {}

class SwimmerSearchLoading extends SwimmerSearchState {}

class SwimmerSearchSuccessful extends SwimmerSearchState {
  const SwimmerSearchSuccessful({required this.fullnameSearch, required this.clubSearch, required this.swimmers}) : super();

  final String fullnameSearch;
  final String clubSearch;
  final List<dynamic> swimmers;

  @override
  List<Object> get props => [fullnameSearch, clubSearch];
}

class SwimmerSearchFailed extends SwimmerSearchState {}
