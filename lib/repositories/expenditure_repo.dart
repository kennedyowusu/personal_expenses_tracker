import 'dart:convert';

import 'package:personal_expenses_tracker/constants/endpoints.dart';
import 'package:personal_expenses_tracker/repositories/models/api_response_model.dart';
import 'package:personal_expenses_tracker/repositories/models/expenditure_list_res.dart';
import 'package:personal_expenses_tracker/services/api_service.dart';
import 'package:personal_expenses_tracker/services/utils.dart';

class ExpenditureRepo {
  Future<(ApiSuccess<ExpenditureListRes>? res, ApiError? err)>
      getExpenditureList() async {
    try {
      final response = await APIService.get(
        url: expenditureUrl,
      );

      if (response.statusCode == 200) {
        final decodedRes =
            ExpenditureListRes.fromJson(jsonDecode(response.body));
        ApiSuccess<ExpenditureListRes> res = ApiSuccess<ExpenditureListRes>(
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
          message: 'Error retrieving expenditure list',
        ),
      );
    }
  }

  Future<(ApiSuccess<void>? res, ApiError? err)> addExpenditure({
    required String category,
    required String nameOfItem,
    required num estimatedAmount,
  }) async {
    try {
      final response = await APIService.post(
        url: expenditureUrl,
        body: {
          "category": category,
          "nameOfItem": nameOfItem,
          "estimatedAmount": estimatedAmount,
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
          message: 'Error adding expenditure',
        ),
      );
    }
  }

  Future<(ApiSuccess<void>? res, ApiError? err)> deleteExpenditure({
    required String expenditureId,
  }) async {
    try {
      final response = await APIService.delete(
        url: '$expenditureUrl/$expenditureId',
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
          message: 'Error deleting expenditure',
        ),
      );
    }
  }
}
