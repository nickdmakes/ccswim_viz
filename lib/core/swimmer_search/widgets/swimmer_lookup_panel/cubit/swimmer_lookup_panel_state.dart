part of 'swimmer_lookup_panel_cubit.dart';

enum SwimmerLookupSubmissionError {none, invalidSubmission}

class SwimmerLookupPanelState extends Equatable {
  const SwimmerLookupPanelState({
    this.swimmerName = const SwimmerName.pure(),
    this.clubName = const ClubName.pure(),
    this.status = FormzStatus.pure,
    this.error = SwimmerLookupSubmissionError.none,
  });

  final SwimmerName swimmerName;
  final ClubName clubName;
  final FormzStatus status;
  final SwimmerLookupSubmissionError error;

  @override
  List<Object> get props => [swimmerName, clubName, status, error];

  SwimmerLookupPanelState copyWith({
    SwimmerName? swimmerName,
    ClubName? clubName,
    FormzStatus? status,
    SwimmerLookupSubmissionError? error,
  }) {
    return SwimmerLookupPanelState(
      swimmerName: swimmerName ?? this.swimmerName,
      clubName: clubName ?? this.clubName,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
