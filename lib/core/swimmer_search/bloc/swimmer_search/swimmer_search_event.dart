part of 'swimmer_search_bloc.dart';

abstract class SwimmerSearchEvent extends Equatable {
  const SwimmerSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchSwimmer extends SwimmerSearchEvent {
  const SearchSwimmer({required this.fullnameSearch, required this.clubSearch}) : super();

  final String fullnameSearch;
  final String clubSearch;
}

class ResetSwimmerSearch extends SwimmerSearchEvent {}
