class RegexUtils {
  static bool isValidEmail(String email) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email);
  }

  static bool hasUpperLowerCase(String value) {
    return value.contains(RegExp(r'(?=.*[a-z])(?=.*[A-Z])'));
  }

  static bool hasDigits(String value) {
    return value.contains(RegExp(r'(?=.*\d)'));
  }

  static bool hasSpecialCharacters(String value) {
    return value.contains(RegExp(r'(?=.*[!@#\$&*~])'));
  }
}
