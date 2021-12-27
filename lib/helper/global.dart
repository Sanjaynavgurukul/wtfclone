import 'package:wtf/helper/regax_validator.dart';

class Global {
  static bool validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regex.hasMatch(value) || value == null)
      return false;
    else
      return true;
  }

  // static RegExInputFormatter amountValidator = RegExInputFormatter.withRegex('^\$|^(0|([0-9][0-9]{0,}))(\\.[0-9]{0,})?\$');
  static RegExInputFormatter amountValidator =
      RegExInputFormatter.withRegex('^[0-9]{0,7}\$');
  static RegExInputFormatter number =
      RegExInputFormatter.withRegex('^(?:[+0]9)?[0-9]{10}\$');
}
