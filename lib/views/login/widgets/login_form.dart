import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/widgets/custom_button.dart';
import 'package:personal_expenses_tracker/widgets/input_error.dart';
import 'package:personal_expenses_tracker/widgets/password_input_field.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/helper/validation.dart';
import 'package:personal_expenses_tracker/views/forget_password/forget_password_screen.dart';
import 'package:personal_expenses_tracker/views/login/providers/login_with_email_provider.dart';
import 'package:personal_expenses_tracker/views/tab_layout.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.watch(loginWithEmailProvider).loginWithEmailFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'Email Address',
            ),
            onChanged: (value) {
              ref.read(loginWithEmailProvider.notifier).onEmailChanged(value);
            },
            validator: validateEmail,
          ),
          const SizedBox(height: 16),
          PasswordInputField(
            isTextObscured: ref.watch(loginWithEmailProvider).isPasswordVisible
                ? false
                : true,
            labelText: 'Password',
            toggleVisibility: () {
              ref
                  .read(loginWithEmailProvider.notifier)
                  .togglePasswordVisibility();
            },
            onChanged: (value) {
              ref
                  .read(loginWithEmailProvider.notifier)
                  .onPasswordChanged(value);
            },
            validator: validatePassword,
          ),
          ErrorTextWidget(
            errorText: ref.watch(loginWithEmailProvider).errorMessage,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ForgetPasswordScreen();
                    },
                  ),
                );
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          ExpenseTrackerCustomButton(
            text: "Login",
            isLoading: ref.watch(loginWithEmailProvider).isLoading,
            onPressed: () async {
              if (!ref
                  .read(loginWithEmailProvider)
                  .loginWithEmailFormKey
                  .currentState!
                  .validate()) {
                return;
              }

              final (res, _) = await ref
                  .read(loginWithEmailProvider.notifier)
                  .loginWithEmail();

              if (res?.data.accessToken != null) {
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const TabLayout(),
                    ),
                    (route) => false,
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
