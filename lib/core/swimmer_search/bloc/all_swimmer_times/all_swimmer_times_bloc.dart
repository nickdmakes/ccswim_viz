import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:ccswims_repository/ccswims_repository.dart';

part 'all_swimmer_times_state.dart';

part 'all_swimmer_times_event.dart';

class AllSwimmerTimesBloc extends Bloc<AllSwimmerTimesEvent, AllSwimmerTimesState> {
  AllSwimmerTimesBloc(this._ccswimsRepository) : super(AllSwimmerTimesFetchNotStarted()) {
    on<FetchAllSwimmerTimes>(_onFetchAllSwimmerTimes);
    on<ResetAllSwimmerTimes>(_onResetAllSwimmerTimes);
  }

  final CCSwimsRepository _ccswimsRepository;

  Future<void> _onFetchAllSwimmerTimes(FetchAllSwimmerTimes event, Emitter<AllSwimmerTimesState> emit) async {
    emit(AllSwimmerTimesFetchLoading());
    try {
      final times = await _ccswimsRepository.allTimesSearch(event.fullname, event.club);
      emit(AllSwimmerTimesFetchSuccessful(fullname: event.fullname, club: event.club, times: times));
    } catch(e) {
      emit(AllSwimmerTimesFetchFailed());
    }
  }

  void _onResetAllSwimmerTimes(ResetAllSwimmerTimes event, Emitter<AllSwimmerTimesState> emit) {
    emit(AllSwimmerTimesFetchNotStarted());
  }
}
