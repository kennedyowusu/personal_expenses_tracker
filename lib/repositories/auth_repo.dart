import 'dart:convert';

import 'package:personal_expenses_tracker/constants/endpoints.dart';
import 'package:personal_expenses_tracker/repositories/models/api_response_model.dart';
import 'package:personal_expenses_tracker/repositories/models/login_with_email_res.dart';
import 'package:personal_expenses_tracker/repositories/models/register_with_email_res.dart';
import 'package:personal_expenses_tracker/services/api_service.dart';
import 'package:personal_expenses_tracker/services/utils.dart';

class AuthRepo {
  Future<(ApiSuccess<LoginWithEmailRes>? res, ApiError? err)> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await APIService.post(
        url: loginWithEmailUrl,
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final decodedRes =
            LoginWithEmailRes.fromJson(jsonDecode(response.body));
        ApiSuccess<LoginWithEmailRes> res = ApiSuccess<LoginWithEmailRes>(
          data: decodedRes,
          statusCode: response.statusCode,
        );
        return (res, null);
      } else {
        final err = ApiError(
          statusCode: response.statusCode,
          message: convertErrorsToString(response.body),
        );
        return (null, err);
      }
    } catch (e) {
      return (
        null,
        ApiError(
          statusCode: 500,
          message: 'Error logging in. Please try again later.',
        ),
      );
    }
  }

  Future<(ApiSuccess<RegisterWithEmailRes>? res, ApiError? err)>
      signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await APIService.post(
        url: signUpWithEmailUrl,
        body: {
          "name": name,
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 201) {
        final decodedRes =
            RegisterWithEmailRes.fromJson(jsonDecode(response.body));
        ApiSuccess<RegisterWithEmailRes> res = ApiSuccess<RegisterWithEmailRes>(
          data: decodedRes,
          statusCode: response.statusCode,
        );
        return (res, null);
      } else {
        final err = ApiError(
          statusCode: response.statusCode,
          message: convertErrorsToString(response.body),
        );
        return (null, err);
      }
    } catch (e) {
      return (
        null,
        ApiError(
          statusCode: 500,
          message: 'Error signing up. Please try again later.',
        ),
      );
    }
  }
}
