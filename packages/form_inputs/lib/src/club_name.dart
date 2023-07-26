import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum ClubNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template firstName}
/// Form input for an firstName input.
/// {@endtemplate}
class ClubName extends FormzInput<String, ClubNameValidationError> {
  /// {@macro Club}
  const ClubName.pure() : super.pure('');

  /// {@macro Club}
  const ClubName.dirty([super.value = '']) : super.dirty();

  static final RegExp _firstNameRegExp = RegExp(
    r'^\b[a-zA-Z0-9_]+\b$',
  );

  @override
  ClubNameValidationError? validator(String? value) {
    return _firstNameRegExp.hasMatch(value ?? '')
        ? null
        : ClubNameValidationError.invalid;
  }
}
