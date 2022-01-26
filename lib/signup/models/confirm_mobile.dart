import 'package:formz/formz.dart';
import 'package:threshold_native/login/models/mobile.dart';
import 'package:threshold_native/utils/validators.dart';

class ConfirmedMobile extends FormzInput<String, MobileValidationError> {
  const ConfirmedMobile.pure()
      : original = const Mobile.pure(),
        super.pure('');
  const ConfirmedMobile.dirty({required this.original, String value = ''})
      : super.dirty(value);

  final Mobile original;

  @override
  MobileValidationError? validator(String? value) {
    return Validators.isSimilar(value ?? '', original.value)
        ? null
        : MobileValidationError.invalid;
  }
}
