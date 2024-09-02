import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expenses_tracker/services/utils.dart';

void main() {
  test('Test invalid JSON string', () {
    const invalidJson = '{"email":[user with this Email already exists.]}';
    final result = convertErrorsToString(invalidJson);
    expect(result, "Something went wrong.");
  });

  test('Test valid JSON string', () {
    const validJson = '{"email":["user with this Email already exists."]}';
    final result = convertErrorsToString(validJson);
    expect(result, "user with this Email already exists.");
  });

  test('Test JSON string with more than one item', () {
    const jsonWithMultipleItems =
        '{"name":["Name is required.", "Name is too short."]}';
    final result = convertErrorsToString(jsonWithMultipleItems);
    expect(result, "Name is required.");
  });

  test('Test with error returned with a single detail object', () {
    const err = '{"detail":"Invalid token."}';
    final result = convertErrorsToString(err);
    expect(result, "Invalid token.");
  });

  test('Test with error returned with a single message object', () {
    const err = '{"message":"An error occurred."}';
    final result = convertErrorsToString(err);
    expect(result, "An error occurred.");
  });
}
