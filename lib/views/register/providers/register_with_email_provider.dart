import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/repositories/auth_repo.dart';
import 'package:personal_expenses_tracker/repositories/models/api_response_model.dart';
import 'package:personal_expenses_tracker/repositories/models/register_with_email_res.dart';
import 'package:personal_expenses_tracker/utils/secure_storage.dart';

class RegisterWithEmailChangeNotifier extends ChangeNotifier {
  final AuthRepo authRepo;
  final LadderSecureStorage secureStorage;

  RegisterWithEmailChangeNotifier({
    required this.authRepo,
    required this.secureStorage,
  });

  final registerWithEmailFormKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String errorMessage = '';
  bool isPasswordVisible = false;
  bool isLoading = false;

  void onNameChanged(String value) {
    name = value.trim();
    notifyListeners();
  }

  void onEmailChanged(String value) {
    email = value.trim();
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    password = value;
    notifyListeners();
  }

  void onConfirmPasswordChanged(String value) {
    confirmPassword = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<(ApiSuccess<RegisterWithEmailRes>? user, ApiError? err)>
      registerWithEmail() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    final (res, err) = await authRepo.signUpWithEmail(
      name: name,
      email: email,
      password: password,
    );

    // Login user after successful registration
    if (res?.data != null) {
      final (loginRes, _) = await authRepo.loginWithEmail(
        email: email,
        password: password,
      );

      if (loginRes != null) {
        await secureStorage.storeAccessToken(loginRes.data.accessToken);
      }
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

final registerWithEmailProvider =
    ChangeNotifierProvider.autoDispose<RegisterWithEmailChangeNotifier>((ref) {
  return RegisterWithEmailChangeNotifier(
    authRepo: AuthRepo(),
    secureStorage: LadderSecureStorage(),
  );
});
