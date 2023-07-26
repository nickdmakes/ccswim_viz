import 'package:ccswim_viz/core/swimmer_search/bloc/swimmer_search/swimmer_search_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'swimmer_lookup_panel_state.dart';

class SwimmerLookupPanelCubit extends Cubit<SwimmerLookupPanelState> {
  SwimmerLookupPanelCubit({required this.swimmerSearchBloc}) : super(const SwimmerLookupPanelState());

  final SwimmerSearchBloc swimmerSearchBloc;

  void swimmerNameChanged(String value) {
    final swimmerName = value == '' ? const SwimmerName.pure() : SwimmerName.dirty(value);
    emit(
      state.copyWith(
        swimmerName: swimmerName,
        error: SwimmerLookupSubmissionError.none,
        status: Formz.validate([swimmerName, state.clubName]),
      ),
    );
  }

  void clubNameChanged(String value) {
    final clubName = value == '' ? const ClubName.pure() : ClubName.dirty(value);
    emit(
      state.copyWith(
        clubName: clubName,
        error: SwimmerLookupSubmissionError.none,
        status: Formz.validate([state.swimmerName, clubName]),
      ),
    );
  }

  void swimmerSearchSubmitted() {
    if(_validForSubmission() && swimmerSearchBloc.state is! SwimmerSearchLoading) {
      swimmerSearchBloc.add(SearchSwimmer(fullnameSearch: state.swimmerName.value, clubSearch: state.clubName.value));
      emit(
          state.copyWith(
            error: SwimmerLookupSubmissionError.none,
          )
      );
    } else {
      emit(
        state.copyWith(
          error: SwimmerLookupSubmissionError.invalidSubmission,
        )
      );
    }
  }

  // Allow empty searches by only requiring one of the fields to be populated
  bool _validForSubmission() {
    if(state.swimmerName.value.isEmpty) {
      if(state.clubName.valid) {
        return true;
      }
    } else if(state.clubName.value.isEmpty) {
      if(state.swimmerName.valid) {
        return true;
      }
    } else if(state.swimmerName.valid && state.clubName.valid) {
      return true;
    }
    return false;
  }
}
