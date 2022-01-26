import 'package:formz/formz.dart';
import 'package:threshold_native/utils/validators.dart';

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    return Validators.isValidUserName(value ?? '')
        ? null
        : UsernameValidationError.invalid;
  }
}
