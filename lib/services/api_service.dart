import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:personal_expenses_tracker/constants/endpoints.dart';
import 'package:personal_expenses_tracker/constants/keys.dart';
import 'package:personal_expenses_tracker/services/utils.dart';
import 'package:personal_expenses_tracker/utils/secure_storage.dart';
import 'package:personal_expenses_tracker/views/login/login_screen.dart';

Future<void> logoutUserOn401Error(Response response) async {
  String authToken = await LadderSecureStorage().getAccessToken();
  if ((response.statusCode == 401) &&
      (convertErrorsToString(response.body) == "Invalid token.") &&
      authToken.isNotEmpty) {
    await LadderSecureStorage().deleteAccessToken();

    Future.delayed(const Duration(seconds: 3), () {
      if (appNavigatorKey.currentState != null) {
        appNavigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    });
  }
}

class APIService {
  static Future<Response> post({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    String accessToken = await LadderSecureStorage().getAccessToken();
    bool isAuth = accessToken.isNotEmpty;

    final response = await http.post(
      Uri.parse(baseUrl + url),
      body: jsonEncode(body),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (isAuth) 'Authorization': accessToken,
      },
    );

    logoutUserOn401Error(response);

    return response;
  }

  static Future<Response> patch({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    String accessToken = await LadderSecureStorage().getAccessToken();
    bool isAuth = accessToken.isNotEmpty;

    final response = await http.patch(
      Uri.parse(baseUrl + url),
      body: jsonEncode(body),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (isAuth) 'Authorization': accessToken,
      },
    );

    logoutUserOn401Error(response);

    return response;
  }

  static Future<Response> put({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    String accessToken = await LadderSecureStorage().getAccessToken();
    bool isAuth = accessToken.isNotEmpty;

    final response = await http.put(
      Uri.parse(baseUrl + url),
      body: jsonEncode(body),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (isAuth) 'Authorization': accessToken,
      },
    );

    logoutUserOn401Error(response);

    return response;
  }

  static Future<Response> delete({
    required String url,
  }) async {
    String accessToken = await LadderSecureStorage().getAccessToken();
    bool isAuth = accessToken.isNotEmpty;

    final response = await http.delete(
      Uri.parse(baseUrl + url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (isAuth) 'Authorization': accessToken,
      },
    );

    logoutUserOn401Error(response);

    return response;
  }

  static Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    String accessToken = await LadderSecureStorage().getAccessToken();
    bool isAuth = accessToken.isNotEmpty;

    final response = await http.get(
      Uri.parse(baseUrl + url).replace(queryParameters: queryParameters),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (isAuth) 'Authorization': accessToken,
      },
    );

    logoutUserOn401Error(response);

    return response;
  }
}
