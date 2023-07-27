import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:ccswims_repository/ccswims_repository.dart';

part 'swimmer_search_state.dart';

part 'swimmer_search_event.dart';

class SwimmerSearchBloc extends Bloc<SwimmerSearchEvent, SwimmerSearchState> {
  SwimmerSearchBloc(this._ccswimsRepository) : super(SwimmerSearchNotStarted()) {
    on<SearchSwimmer>(_onSearchSwimmer);
    on<ResetSwimmerSearch>(_onResetSwimmerSearch);
  }

  final CCSwimsRepository _ccswimsRepository;

  Future<void> _onSearchSwimmer(SearchSwimmer event, Emitter<SwimmerSearchState> emit) async {
    emit(SwimmerSearchLoading());
    try {
      // TODO: Remove this mock data
      // final swimmers = await _ccswimsRepository.mockSwimmerSearch();
      final swimmers = await _ccswimsRepository.swimmerSearch(event.fullnameSearch, event.clubSearch);
      emit(SwimmerSearchSuccessful(fullnameSearch: event.fullnameSearch, clubSearch: event.clubSearch, swimmers: swimmers));
    } catch(e) {
      emit(SwimmerSearchFailed());
    }
  }

  void _onResetSwimmerSearch(ResetSwimmerSearch event, Emitter<SwimmerSearchState> emit) {
    emit(SwimmerSearchNotStarted());
  }
}
