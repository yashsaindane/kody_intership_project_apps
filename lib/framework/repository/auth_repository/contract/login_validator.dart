import '../../../../UI/utils/theme/text_class.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return TextClass.emailCannotBeEmpty;
  }
  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return TextClass.enterValidEmailAddress;
  }
  return null;
}
