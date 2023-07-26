import 'package:formz/formz.dart';

/// Validation errors for the [SwimmerName] [FormzInput].
enum SwimmerNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template firstName}
/// Form input for an firstName input.
/// {@endtemplate}
class SwimmerName extends FormzInput<String, SwimmerNameValidationError> {
  /// {@macro SwimmerName}
  const SwimmerName.pure() : super.pure('');

  /// {@macro SwimmerName}
  const SwimmerName.dirty([super.value = '']) : super.dirty();

  static final RegExp _firstNameRegExp = RegExp(
    r'^(?!.*\s{2})\b\w+(?: \w+)?\b$',
  );

  @override
  SwimmerNameValidationError? validator(String? value) {
    return _firstNameRegExp.hasMatch(value ?? '')
        ? null
        : SwimmerNameValidationError.invalid;
  }
}
