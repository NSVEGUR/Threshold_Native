import 'package:formz/formz.dart';
import 'package:threshold_native/login/models/password.dart';
import 'package:threshold_native/utils/validators.dart';

class ConfirmedPassword extends FormzInput<String, PasswordValidationError> {
  const ConfirmedPassword.pure()
      : original = const Password.pure(),
        super.pure('');
  const ConfirmedPassword.dirty({required this.original, String value = ''})
      : super.dirty(value);

  final Password original;

  @override
  PasswordValidationError? validator(String? value) {
    return Validators.isSimilar(value ?? '', original.value)
        ? null
        : PasswordValidationError.invalid;
  }
}
