import 'package:formz/formz.dart';
import 'package:threshold_native/utils/validators.dart';

enum MobileValidationError { invalid }

class Mobile extends FormzInput<String, MobileValidationError> {
  const Mobile.pure() : super.pure('');
  const Mobile.dirty([String value = '']) : super.dirty(value);

  @override
  MobileValidationError? validator(String? value) {
    return Validators.isValidMobile(value ?? '')
        ? null
        : MobileValidationError.invalid;
  }
}
