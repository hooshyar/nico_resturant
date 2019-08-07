//empty Validator
import 'config.dart';

String emptyTextValidator(String value) {
  if (value.isEmpty) {
    return 'Should not be empty';
  }
}

//2character number
String validateNumber(String value) {
  if (!RegExp(globalNumberPattern).hasMatch(value)) {
    return 'En numbers please';
  } else
    return null;
}

String updateValidateNumber(String value) {
  if (value.isNotEmpty) {
    if (!RegExp(globalNumberPattern).hasMatch(value)) {
      return 'English numbers please';
    } else
      return null;
  }
}
