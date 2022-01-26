import 'package:formz/formz.dart';
import 'package:threshold_native/utils/validators.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    return Validators.isValidPassword(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}
