import 'package:personal_expenses_tracker/helper/regex_utils.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter email address';
  }
  if (!RegexUtils.isValidEmail(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  return null;
}

String? validatePasswordMatch(String? password, String? confirmPassword) {
  if (password != confirmPassword) {
    return 'Passwords do not match';
  }
  return null;
}

String? validateStrongPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  if (!RegexUtils.hasUpperLowerCase(value)) {
    return 'Password must contain at least one uppercase and one lowercase letter';
  }
  if (!RegexUtils.hasDigits(value)) {
    return 'Password must contain at least one digit';
  }
  if (!RegexUtils.hasSpecialCharacters(value)) {
    return 'Password must contain at least one special character';
  }

  return null;
}

String? validateFullName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your full name';
  } else if (value.length < 3) {
    return 'Full name must be at least 3 characters';
  }
  return null;
}
