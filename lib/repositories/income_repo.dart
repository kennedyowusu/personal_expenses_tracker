import 'dart:convert';

import 'package:personal_expenses_tracker/constants/endpoints.dart';
import 'package:personal_expenses_tracker/repositories/models/api_response_model.dart';
import 'package:personal_expenses_tracker/repositories/models/income_list_res.dart';
import 'package:personal_expenses_tracker/services/api_service.dart';
import 'package:personal_expenses_tracker/services/utils.dart';

class IncomeRepo {
  Future<(ApiSuccess<IncomeListRes>? res, ApiError? err)>
      getIncomeList() async {
    try {
      final response = await APIService.get(
        url: incomeUrl,
      );

      if (response.statusCode == 200) {
        final decodedRes = IncomeListRes.fromJson(jsonDecode(response.body));
        ApiSuccess<IncomeListRes> res = ApiSuccess<IncomeListRes>(
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
          message: 'Error retrieving income list',
        ),
      );
    }
  }

  Future<(ApiSuccess<void>? res, ApiError? err)> addIncome({
    required String nameOfRevenue,
    required num amount,
  }) async {
    try {
      final response = await APIService.post(
        url: incomeUrl,
        body: {
          "nameOfRevenue": nameOfRevenue,
          "amount": amount,
        },
      );

      if (response.statusCode == 201) {
        ApiSuccess<void> res = ApiSuccess<void>(
          data: null,
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
          message: 'Error adding income',
        ),
      );
    }
  }

  Future<(ApiSuccess<void>? res, ApiError? err)> deleteIncome({
    required String incomeId,
  }) async {
    try {
      final response = await APIService.delete(
        url: '$incomeUrl/$incomeId',
      );

      if (response.statusCode == 200) {
        ApiSuccess<void> res = ApiSuccess<void>(
          data: null,
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
          message: 'Error deleting income',
        ),
      );
    }
  }
}
