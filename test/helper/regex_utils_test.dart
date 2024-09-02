import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expenses_tracker/helper/regex_utils.dart';

void main() {
  test('Test valid email', () {
    const validEmail = 'test@example.com';
    final isValid = RegexUtils.isValidEmail(validEmail);
    expect(isValid, isTrue);
  });

  test('Test valid email with underscore', () {
    const validEmail = 'valid_email@example.com';
    final isValid = RegexUtils.isValidEmail(validEmail);
    expect(isValid, isTrue);
  });

  test('Test invalid email', () {
    const invalidEmail = 'invalid_email';
    final isValid = RegexUtils.isValidEmail(invalidEmail);
    expect(isValid, isFalse);
  });

  test('Test hasUpperLowerCase with valid value', () {
    const validValue = 'Password123';
    final hasUpperLowerCase = RegexUtils.hasUpperLowerCase(validValue);
    expect(hasUpperLowerCase, isTrue);
  });

  test('Test hasUpperLowerCase with invalid value', () {
    const invalidValue = 'password';
    final hasUpperLowerCase = RegexUtils.hasUpperLowerCase(invalidValue);
    expect(hasUpperLowerCase, isFalse);
  });

  test('Test hasDigits with valid value', () {
    const validValue = 'Password123';
    final hasDigits = RegexUtils.hasDigits(validValue);
    expect(hasDigits, isTrue);
  });

  test('Test hasDigits with invalid value', () {
    const invalidValue = 'Password';
    final hasDigits = RegexUtils.hasDigits(invalidValue);
    expect(hasDigits, isFalse);
  });

  test('Test hasSpecialCharacters with valid value', () {
    const validValue = 'Password@123';
    final hasSpecialCharacters = RegexUtils.hasSpecialCharacters(validValue);
    expect(hasSpecialCharacters, isTrue);
  });

  test('Test hasSpecialCharacters with invalid value', () {
    const invalidValue = 'Password123';
    final hasSpecialCharacters = RegexUtils.hasSpecialCharacters(invalidValue);
    expect(hasSpecialCharacters, isFalse);
  });
}
