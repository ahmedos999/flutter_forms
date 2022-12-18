import 'package:formz/formz.dart';

enum PhoneValidationError { invalid }

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure([super.value = '']) : super.pure();
  const Phone.dirty([super.value = '']) : super.dirty();

  @override
  PhoneValidationError? validator(String? value) {
    if (value != null && value.length > 10) {
      return null;
    }
    return PhoneValidationError.invalid;
  }
}
