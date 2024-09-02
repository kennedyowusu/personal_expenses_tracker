import 'dart:convert';

String convertErrorsToString(String error) {
  try {
    final decodedError = jsonDecode(error);

    if (decodedError['message'] != null) {
      return decodedError['message'];
    }

    if (decodedError['detail'] != null) {
      return decodedError['detail'];
    }

    String errorMessage = '';

    decodedError.forEach((key, value) {
      errorMessage += value[0];
    });

    return errorMessage;
  } catch (e) {
    return "Something went wrong.";
  }
}
