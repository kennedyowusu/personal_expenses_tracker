import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/repositories/auth_repo.dart';
import 'package:personal_expenses_tracker/repositories/models/api_response_model.dart';
import 'package:personal_expenses_tracker/repositories/models/login_with_email_res.dart';
import 'package:personal_expenses_tracker/utils/secure_storage.dart';

class LoginWithEmailChangeNotifier extends ChangeNotifier {
  final AuthRepo authRepo;
  final LadderSecureStorage secureStorage;

  LoginWithEmailChangeNotifier({
    required this.authRepo,
    required this.secureStorage,
  });

  final loginWithEmailFormKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String errorMessage = '';
  bool isPasswordVisible = false;
  bool isLoading = false;

  void onEmailChanged(String value) {
    email = value.trim();
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    password = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<(ApiSuccess<LoginWithEmailRes>? res, ApiError? err)>
      loginWithEmail() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    final (res, err) = await authRepo.loginWithEmail(
      email: email,
      password: password,
    );

    if (res != null) {
      await secureStorage.storeAccessToken(res.data.accessToken);
    }

    if (err != null) {
      errorMessage = err.message;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
    return (res, err);
  }
}

final loginWithEmailProvider =
    ChangeNotifierProvider.autoDispose<LoginWithEmailChangeNotifier>((ref) {
  return LoginWithEmailChangeNotifier(
    authRepo: AuthRepo(),
    secureStorage: LadderSecureStorage(),
  );
});
