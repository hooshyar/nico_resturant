//empty Validator
import 'config.dart';

emptyTextValidator(String value) {
  if (value.isEmpty) {
    return 'Should not be empty';
  }
}

//2character number
validateNumber(String value) {
  if (!RegExp(globalNumberPattern).hasMatch(value)) {
    return 'En numbers please';
  } else
    return null;
}

updateValidateNumber(String value) {
  if (value.isNotEmpty) {
    if (!RegExp(globalNumberPattern).hasMatch(value)) {
      return 'English numbers please';
    } else
      return null;
  }
}
